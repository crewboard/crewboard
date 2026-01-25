import 'package:serverpod/serverpod.dart';
import 'dart:io';
import '../generated/protocol.dart';
import '../utils.dart';
import 'package:collection/collection.dart';

class PlannerEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Get planner data (buckets with tickets) for an app
  Future<GetPlannerDataResponse> getPlannerData(
    Session session,
    UuidValue appId,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    final appIdVal = appId;

    // Check if app belongs to the same organization
    final app = await PlannerApp.db.findById(session, appIdVal);
    if (app == null || app.organizationId != user.organizationId) {
      stdout.writeln(
        'UNAUTHORIZED: User ${user.userName} (Org: ${user.organizationId}) attempted to access App $appIdVal (Org: ${app?.organizationId})',
      );
      throw Exception('Unauthorized access to app');
    }

    final userId = user.id!;

    // Fetch buckets for app
    final buckets = await Bucket.db.find(
      session,
      where: (t) => t.appId.equals(appIdVal),
    );

    if (buckets.isEmpty) {
      return GetPlannerDataResponse(buckets: []);
    }

    final bucketsWithTickets = <BucketModel>[];

    for (final bucket in buckets) {
      // Get bucket-ticket mappings with all ticket relations included
      final bucketTicketMaps = await BucketTicketMap.db.find(
        session,
        where: (t) => t.bucketId.equals(bucket.id!),
        orderBy: (t) => t.order,
        include: BucketTicketMap.include(
          ticket: Ticket.include(
            status: Status.include(),
            priority: Priority.include(),
            type: TicketType.include(color: SystemColor.include()),
          ),
        ),
      );

      final ticketModels = <PlannerTicket>[];
      for (final map in bucketTicketMaps) {
        final ticket = map.ticket;
        if (ticket == null) continue;

        // Fetch assignees for this ticket
        final assigneesList = await _getAssigneesForTicket(session, ticket.id!);

        // Fetch attachments for this ticket
        final attachments = await TicketAttachment.db.find(
          session,
          where: (t) => t.ticketId.equals(ticket.id!),
        );
        final attachmentModels = attachments
            .map(
              (a) => AttachmentModel(
                id: a.id!,
                name: a.attachmentName,
                size: a.attachmentSize,
                url: a.attachmentUrl,
                type: a.attachmentType,
              ),
            )
            .toList();

        ticketModels.add(
          PlannerTicket(
            id: ticket.id!,
            ticketName: ticket.ticketName,
            ticketBody: ticket.ticketBody,
            statusName: ticket.status?.statusName ?? 'Unknown',
            priorityName: ticket.priority?.priorityName ?? '',
            typeName: ticket.type?.typeName ?? '',
            typeColor: ticket.type?.color?.color ?? '#000000',
            deadline: ticket.deadline?.toIso8601String(),
            assignees: assigneesList,
            holder: 'Unknown',
            creds: ticket.creds.toDouble(),
            hasNewActivity: await _hasNewActivity(session, ticket.id!, userId),
            latestActivity: await _getLatestActivity(session, ticket.id!),
            attachments: attachmentModels,
          ),
        );
      }

      bucketsWithTickets.add(
        BucketModel(
          bucketId: bucket.id!,
          bucketName: bucket.bucketName,
          tickets: ticketModels,
          isDefault: bucket.isDefault,
        ),
      );
    }

    return GetPlannerDataResponse(buckets: bucketsWithTickets);
  }

  /// Fetch initial data for "Add Ticket" form
  Future<GetAddTicketDataResponse> getAddTicketData(
    Session session,
  ) async {
    final userRec = await AuthHelper.getAuthenticatedUser(session);
    final users = await User.db.find(
      session,
      where: (t) => t.organizationId.equals(userRec.organizationId),
    );
    final userModels = <UserModel>[];
    for (final user in users) {
      final color = await SystemColor.db.findById(session, user.colorId);
      userModels.add(
        UserModel(
          userId: user.id!,
          userName: user.userName,
          color: color?.color ?? '#000000',
          selected: false,
        ),
      );
    }

    final statuses = await Status.db.find(session);
    final statusModels = statuses
        .map((s) => StatusModel(statusId: s.id!, statusName: s.statusName))
        .toList();

    final priorities = await Priority.db.find(session);
    final priorityModels = priorities
        .map(
          (p) => PriorityModel(
            priorityId: p.id!,
            priorityName: p.priorityName,
            priority: p.priority,
          ),
        )
        .toList();

    final types = await TicketType.db.find(session);
    final typeModels = <TypeModel>[];
    for (final t in types) {
      final color = await SystemColor.db.findById(session, t.colorId);
      typeModels.add(
        TypeModel(
          typeId: t.id!,
          typeName: t.typeName,
          color: color?.color ?? '#000000',
          colorId: t.colorId,
        ),
      );
    }

    // Default flows - Placeholder data
    // Fetch available flows
    final flows = await FlowModel.db.find(session);

    return GetAddTicketDataResponse(
      users: userModels,
      statuses: statusModels,
      priorities: priorityModels,
      types: typeModels,
      flows: flows,
    );
  }

  /// Create a new ticket
  Future<bool> addTicket(
    Session session,
    AddTicketRequest request,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);

    // Validate app
    final app = await PlannerApp.db.findById(session, request.appId);
    if (app == null || app.organizationId != user.organizationId) {
      throw Exception('Unauthorized');
    }

    final userId = user.id!;

    DateTime? deadline;
    if (request.ticket.deadline != null) {
      deadline = DateTime.tryParse(request.ticket.deadline!);
    }

    final ticket = await Ticket.db.insertRow(
      session,
      Ticket(
        userId: userId,
        appId: request.appId,
        ticketName: request.ticket.ticketName,
        ticketBody: request.ticket.ticketBody,
        statusId: request.ticket.status.statusId,
        priorityId: request.ticket.priority.priorityId,
        typeId: request.ticket.type.typeId,
        checklist: [],
        flows: request.ticket.flows ?? '',
        creds: request.ticket.creds.toInt(),
        deadline: deadline,
        createdAt: DateTime.now(),
      ),
    );

    // Map to bucket - Shift existing tickets down
    final existingMaps = await BucketTicketMap.db.find(
      session,
      where: (t) => t.bucketId.equals(request.bucketId),
    );
    for (final map in existingMaps) {
      map.order = map.order + 1;
      await BucketTicketMap.db.updateRow(session, map);
    }

    await BucketTicketMap.db.insertRow(
      session,
      BucketTicketMap(
        bucketId: request.bucketId,
        ticketId: ticket.id!,
        order: 1, // New ticket at the top
      ),
    );

    // Save attachments
    for (final attachment in request.ticket.attachments) {
      await TicketAttachment.db.insertRow(
        session,
        TicketAttachment(
          ticketId: ticket.id!,
          attachmentName: attachment.name,
          attachmentSize: attachment.size,
          attachmentUrl: attachment.url,
          attachmentType: attachment.type,
        ),
      );
    }

    // LOG INITIAL THREAD ACTIVITY
    await TicketStatusChange.db.insertRow(
      session,
      TicketStatusChange(
        ticketId: ticket.id!,
        userId: userId,
        oldStatusId: null,
        newStatusId: ticket.statusId,
        changedAt: DateTime.now(),
      ),
    );

    await PlannerActivity.db.insertRow(
      session,
      PlannerActivity(
        ticketId: ticket.id!,
        ticketName: ticket.ticketName,
        userName: user.userName,
        userColor:
            (await SystemColor.db.findById(session, user.colorId))?.color ??
            '#000000',
        action: 'created ticket',
        details: 'Initial status: ${request.ticket.status.statusName}',
        createdAt: DateTime.now(),
      ),
    );

    return true;
  }

  /// Search/list all tickets in project
  Future<GetAllTicketsResponse> getAllTickets(
    Session session,
    UuidValue appId,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);

    // Check if app belongs to the same organization
    final app = await PlannerApp.db.findById(session, appId);
    if (app == null || app.organizationId != user.organizationId) {
      throw Exception('Unauthorized access to app');
    }

    final tickets = await Ticket.db.find(
      session,
      where: (t) => t.appId.equals(appId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      include: Ticket.include(
        status: Status.include(),
        priority: Priority.include(),
        type: TicketType.include(color: SystemColor.include()),
      ),
    );

    final ticketModels = <PlannerTicket>[];
    for (final ticket in tickets) {
      ticketModels.add(
        PlannerTicket(
          id: ticket.id!,
          ticketName: ticket.ticketName,
          ticketBody: ticket.ticketBody,
          statusName: ticket.status?.statusName ?? 'Unknown',
          priorityName: ticket.priority?.priorityName ?? '',
          typeName: ticket.type?.typeName ?? '',
          typeColor: ticket.type?.color?.color ?? '#000000',
          deadline: ticket.deadline?.toIso8601String(),
          createdAt: ticket.createdAt,
          assignees: await _getAssigneesForTicket(session, ticket.id!),
          holder: 'Unknown',
          creds: ticket.creds.toDouble(),
          hasNewActivity: await _hasNewActivity(session, ticket.id!, user.id!),
          latestActivity: await _getLatestActivity(session, ticket.id!),
        ),
      );
    }

    return GetAllTicketsResponse(tickets: ticketModels);
  }

  /// Get detailed ticket data
  Future<GetTicketDataResponse> getTicketData(
    Session session,
    UuidValue ticketId,
  ) async {
    final userRec = await AuthHelper.getAuthenticatedUser(session);
    final ticket = await Ticket.db.findById(
      session,
      ticketId,
      include: Ticket.include(
        user: User.include(),
        status: Status.include(),
        priority: Priority.include(),
        type: TicketType.include(color: SystemColor.include()),
      ),
    );

    if (ticket == null ||
        ticket.user?.organizationId != userRec.organizationId) {
      throw Exception('Ticket not found or unauthorized');
    }

    // Fetch assignees
    final assigneesList = <UserModel>[];
    final mapsForTicket = await BucketTicketMap.db.find(
      session,
      where: (t) => t.ticketId.equals(ticket.id!),
      include: BucketTicketMap.include(
        bucket: Bucket.include(
          user: User.include(color: SystemColor.include()),
        ),
      ),
    );

    for (final map in mapsForTicket) {
      final user = map.bucket?.user;
      if (user != null) {
        assigneesList.add(
          UserModel(
            userId: user.id!,
            userName: user.userName,
            color: user.color?.color ?? '#000000',
            selected: false,
          ),
        );
      }
    }

    // Fetch attachments
    final attachments = await TicketAttachment.db.find(
      session,
      where: (t) => t.ticketId.equals(ticket.id!),
    );
    final attachmentModels = attachments
        .map(
          (a) => AttachmentModel(
            id: a.id!,
            name: a.attachmentName,
            size: a.attachmentSize,
            url: a.attachmentUrl,
            type: a.attachmentType,
          ),
        )
        .toList();

    String formattedDeadline = ticket.deadline?.toIso8601String() ?? '';

    final ticketModel = TicketModel(
      id: ticket.id!,
      ticketName: ticket.ticketName,
      ticketBody: ticket.ticketBody,
      status: StatusModel(
        statusId:
            ticket.status?.id ??
            UuidValue.fromString('00000000-0000-4000-8000-000000000000'),
        statusName: ticket.status?.statusName ?? '',
      ),
      priority: PriorityModel(
        priorityId:
            ticket.priority?.id ??
            UuidValue.fromString('00000000-0000-4000-8000-000000000000'),
        priorityName: ticket.priority?.priorityName ?? '',
        priority: ticket.priority?.priority ?? 0,
      ),
      type: TypeModel(
        typeId:
            ticket.type?.id ??
            UuidValue.fromString('00000000-0000-4000-8000-000000000000'),
        typeName: ticket.type?.typeName ?? '',
        color: ticket.type?.color?.color ?? '#000000',
        colorId:
            ticket.type?.colorId ??
            UuidValue.fromString('00000000-0000-4000-8000-000000000000'),
      ),
      checklist: ticket.checklist ?? [],
      flows: ticket.flows,
      deadline: formattedDeadline,
      creds: ticket.creds.toDouble(),
      assignees: assigneesList,
      attachments: attachmentModels,
    );

    return GetTicketDataResponse(ticket: ticketModel);
  }

  /// Get thread (comments + status changes) for a ticket
  Future<GetTicketThreadResponse> getTicketThread(
    Session session,
    UuidValue ticketId,
  ) async {
    final activities = await PlannerActivity.db.find(
      session,
      where: (t) => t.ticketId.equals(ticketId),
      orderBy: (t) => t.createdAt,
    );

    final List<ThreadItemModel> items = [];

    for (final activity in activities) {
      items.add(
        ThreadItemModel(
          id: activity.id!,
          userId: UuidValue.fromString(
            '00000000-0000-0000-0000-000000000000',
          ), // Placeholder since PlannerActivity doesn't have userId currently (oops)
          userName: activity.userName,
          userColor: activity.userColor,
          message: activity.action == 'commented' ? activity.details : null,
          action: activity.action,
          details: activity.action != 'commented' ? activity.details : null,
          createdAt: activity.createdAt.toIso8601String(),
          type: activity.action == 'commented' ? 'comment' : 'activity',
        ),
      );
    }

    // Record view
    final user = await AuthHelper.getAuthenticatedUser(session);
    final userId = user.id!;
    final existingView = await TicketView.db.findFirstRow(
      session,
      where: (t) => t.ticketId.equals(ticketId) & t.userId.equals(userId),
    );

    if (existingView != null) {
      existingView.lastRead = DateTime.now();
      await TicketView.db.updateRow(session, existingView);
    } else {
      await TicketView.db.insertRow(
        session,
        TicketView(
          ticketId: ticketId,
          userId: userId,
          lastRead: DateTime.now(),
        ),
      );
    }

    return GetTicketThreadResponse(items: items);
  }

  /// Get comments for a ticket
  Future<GetTicketCommentsResponse> getTicketComments(
    Session session,
    UuidValue ticketId,
  ) async {
    final comments = await TicketComment.db.find(
      session,
      where: (t) => t.ticketId.equals(ticketId),
      orderBy: (t) => t.createdAt,
    );

    final commentModels = <CommentModel>[];
    for (final comment in comments) {
      final user = await User.db.findById(session, comment.userId);
      commentModels.add(
        CommentModel(
          commentId: comment.id!,
          userId: comment.userId,
          userName: user?.userName ?? 'Unknown',
          message: comment.message,
          createdAt: comment.createdAt?.toIso8601String() ?? '',
          userColor: user?.color?.color ?? '#000000',
        ),
      );
    }

    return GetTicketCommentsResponse(comments: commentModels);
  }

  /// Add a comment to a ticket
  Future<bool> addComment(
    Session session,
    AddCommentRequest request,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    final userId = user.id!;

    await TicketComment.db.insertRow(
      session,
      TicketComment(
        ticketId: request.ticketId,
        userId: userId,
        message: request.message,
        createdAt: DateTime.now(),
      ),
    );

    final ticket = await Ticket.db.findById(session, request.ticketId);
    final userColor = await SystemColor.db.findById(session, user.colorId);

    await PlannerActivity.db.insertRow(
      session,
      PlannerActivity(
        ticketId: request.ticketId,
        ticketName: ticket?.ticketName ?? 'Unknown',
        userName: user.userName,
        userColor: userColor?.color ?? '#000000',
        action: 'commented',
        details: request.message,
        createdAt: DateTime.now(),
      ),
    );

    return true;
  }

  /// Add a new bucket
  Future<bool> addBucket(
    Session session,
    AddBucketRequest request,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);

    // Validate app
    final app = await PlannerApp.db.findById(session, request.appId);
    if (app == null || app.organizationId != user.organizationId) {
      throw Exception('Unauthorized');
    }

    final userId = user.id!;

    await Bucket.db.insertRow(
      session,
      Bucket(
        userId: userId,
        appId: request.appId,
        bucketName: request.bucketName,
      ),
    );

    return true;
  }

  /// Move ticket between buckets
  Future<bool> changeBucket(
    Session session,
    ChangeBucketRequest request,
  ) async {
    final ticketId = request.ticketId;
    final oldBucketId = request.oldBucketId;
    final newBucketId = request.newBucketId;

    // Remove from old bucket
    final oldMaps = await BucketTicketMap.db.find(
      session,
      where: (t) =>
          (t.bucketId.equals(oldBucketId)) & (t.ticketId.equals(ticketId)),
    );

    for (final map in oldMaps) {
      await BucketTicketMap.db.deleteRow(session, map);
    }

    // Reorder remaining tickets in old bucket
    final remainingOldMaps = await BucketTicketMap.db.find(
      session,
      where: (t) => t.bucketId.equals(oldBucketId),
      orderBy: (t) => t.order,
    );

    for (var i = 0; i < remainingOldMaps.length; i++) {
      remainingOldMaps[i].order = i + 1;
      await BucketTicketMap.db.updateRow(session, remainingOldMaps[i]);
    }

    // Update order in new bucket: shift tickets from the new position onwards
    final newBucketMaps = await BucketTicketMap.db.find(
      session,
      where: (t) => t.bucketId.equals(newBucketId),
      orderBy: (t) => t.order,
    );

    for (final map in newBucketMaps) {
      if (map.order >= request.newOrder) {
        map.order = map.order + 1;
        await BucketTicketMap.db.updateRow(session, map);
      }
    }

    // Insert into new bucket
    await BucketTicketMap.db.insertRow(
      session,
      BucketTicketMap(
        bucketId: newBucketId,
        ticketId: ticketId,
        order: request.newOrder < 1 ? 1 : request.newOrder,
      ),
    );

    // LOG STATUS CHANGE (Optional/Heuristic: if bucket name matches status name)
    // For now, let's just log it if we can find a status with same name as bucket
    try {
      final bucket = await Bucket.db.findById(session, newBucketId);
      final ticket = await Ticket.db.findById(session, ticketId);
      if (bucket != null && ticket != null) {
        final newStatus = await Status.db.findFirstRow(
          session,
          where: (t) => t.statusName.equals(bucket.bucketName),
        );
        if (newStatus != null && newStatus.id != ticket.statusId) {
          final oldStatusId = ticket.statusId;
          ticket.statusId = newStatus.id!;
          await Ticket.db.updateRow(session, ticket);

          final user = await AuthHelper.getAuthenticatedUser(session);
          await TicketStatusChange.db.insertRow(
            session,
            TicketStatusChange(
              ticketId: ticket.id!,
              userId: user.id!,
              oldStatusId: oldStatusId,
              newStatusId: newStatus.id!,
              changedAt: DateTime.now(),
            ),
          );

          await PlannerActivity.db.insertRow(
            session,
            PlannerActivity(
              ticketId: ticket.id!,
              ticketName: ticket.ticketName,
              userName: user.userName,
              userColor:
                  (await SystemColor.db.findById(
                    session,
                    user.colorId,
                  ))?.color ??
                  '#000000',
              action: 'changed status',
              details:
                  'from ${ticket.status?.statusName ?? 'None'} to ${newStatus.statusName}',
              createdAt: DateTime.now(),
            ),
          );
        }
      }
    } catch (e) {
      // Ignore heuristic failures
      session.log('Status change logging failed: $e');
    }

    return true;
  }

  /// Update ticket fields
  Future<bool> updateTicket(
    Session session,
    TicketModel updatedTicket,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    // Find the existing ticket in DB
    final ticket = await Ticket.db.findById(session, updatedTicket.id);
    if (ticket == null) {
      return false;
    }

    // TODO: Verify authorization (check if user has access to app/org)
    // For now assuming if they can find it, they can edit it (basic check)
    if (ticket.userId != user.id) {
       // Ideally check organization/team permissions here
    }

    // 1. Detect Status Change
    final newStatusId = updatedTicket.status.statusId;
    if (ticket.statusId != newStatusId) {
      final oldStatusId = ticket.statusId;
      ticket.statusId = newStatusId;
      
      // Log status change
      await TicketStatusChange.db.insertRow(
        session,
        TicketStatusChange(
          ticketId: ticket.id!,
          userId: user.id!,
          oldStatusId: oldStatusId,
          newStatusId: newStatusId,
          changedAt: DateTime.now(),
        ),
      );

      final newStatus = await Status.db.findById(session, newStatusId);
      final oldStatus = await Status.db.findById(session, oldStatusId);

      await PlannerActivity.db.insertRow(
        session,
        PlannerActivity(
          ticketId: ticket.id!,
          ticketName: ticket.ticketName,
          userName: user.userName,
          userColor: (await SystemColor.db.findById(session, user.colorId))?.color ?? '#000000',
          action: 'changed status',
          details: 'from ${oldStatus?.statusName ?? 'None'} to ${newStatus?.statusName ?? 'Unknown'}',
          createdAt: DateTime.now(),
        ),
      );
    }

    // 2. Update Basic Fields
    ticket.ticketName = updatedTicket.ticketName;
    ticket.ticketBody = updatedTicket.ticketBody;
    ticket.priorityId = updatedTicket.priority.priorityId;
    ticket.typeId = updatedTicket.type.typeId;
    ticket.creds = updatedTicket.creds.toInt();
    
    // Parse deadline from string if it exists
    if (updatedTicket.deadline != null && updatedTicket.deadline!.isNotEmpty) {
       ticket.deadline = DateTime.tryParse(updatedTicket.deadline!);
    } else {
       ticket.deadline = null;
    }
    
    // 3. Update Assignees
    final currentMaps = await BucketTicketMap.db.find(
      session,
      where: (t) => t.ticketId.equals(ticket.id!),
      include: BucketTicketMap.include(bucket: Bucket.include()),
    );

    final currentAssigneeIds =
        currentMaps.map((m) => m.bucket?.userId).whereType<UuidValue>().toSet();
    final newAssigneeIds =
        updatedTicket.assignees.map((u) => u.userId).toSet();

    // To Remove
    final toRemove = currentAssigneeIds.difference(newAssigneeIds);
    if (toRemove.isNotEmpty) {
      final mapsToRemove =
          currentMaps
              .where((m) => toRemove.contains(m.bucket?.userId))
              .toList();
      for (var map in mapsToRemove) {
        await BucketTicketMap.db.deleteRow(session, map);
      }
    }

    // To Add
    final toAdd = newAssigneeIds.difference(currentAssigneeIds);
    for (final userId in toAdd) {
      // Find a bucket for this user in this app
      // We explicitly look for a default bucket first, but finding any is okay
      var userBuckets = await Bucket.db.find(
        session,
        where: (b) => b.userId.equals(userId) & b.appId.equals(ticket.appId),
      );
      
      Bucket? targetBucket;
      if (userBuckets.isNotEmpty) {
        // Try to find default
        targetBucket =
            userBuckets.firstWhereOrNull((b) => b.isDefault) ??
            userBuckets.first;
      } else {
        // Create a new bucket for this user in this app on-the-fly
        targetBucket = await Bucket.db.insertRow(
          session,
          Bucket(
            userId: userId,
            appId: ticket.appId,
            bucketName: 'New',
          ),
        );
      }
      
      // targetBucket is guaranteed to be non-null here

        await BucketTicketMap.db.insertRow(
          session,
          BucketTicketMap(
            bucketId: targetBucket.id!,
            ticketId: ticket.id!,
            order: 0, // Add to top
          ),
        );
        
        // LOG ACTIVITY for adding assignee
        final addedUser = await User.db.findById(session, userId);
        if (addedUser != null) {
          await PlannerActivity.db.insertRow(
            session,
            PlannerActivity(
              ticketId: ticket.id!,
              ticketName: ticket.ticketName,
              userName: user.userName,
              userColor: (await SystemColor.db.findById(session, user.colorId))?.color ?? '#000000',
              action: 'added assignee',
              details: addedUser.userName,
              createdAt: DateTime.now(),
            ),
          );
        }

    }

    // LOG REMOVAL ACTIVITY
    for (final userId in toRemove) {
       final removedUser = await User.db.findById(session, userId);
       if (removedUser != null) {
          await PlannerActivity.db.insertRow(
            session,
            PlannerActivity(
              ticketId: ticket.id!,
              ticketName: ticket.ticketName,
              userName: user.userName,
              userColor: (await SystemColor.db.findById(session, user.colorId))?.color ?? '#000000',
              action: 'removed assignee',
              details: removedUser.userName,
              createdAt: DateTime.now(),
            ),
          );
       }
    }

    // 4. Update Attachments
    // Delete existing attachments
    final existingAttachments = await TicketAttachment.db.find(
      session,
      where: (t) => t.ticketId.equals(ticket.id!),
    );
    for (final attachment in existingAttachments) {
      await TicketAttachment.db.deleteRow(session, attachment);
    }

    // Insert new attachments
    for (final attachment in updatedTicket.attachments) {
      await TicketAttachment.db.insertRow(
        session,
        TicketAttachment(
          ticketId: ticket.id!,
          attachmentName: attachment.name,
          attachmentSize: attachment.size,
          attachmentUrl: attachment.url,
          attachmentType: attachment.type,
        ),
      );
    }

    // Save the ticket row
    await Ticket.db.updateRow(session, ticket);
    return true;
  }

  Future<List<PlannerAssignee>> _getAssigneesForTicket(
    Session session,
    UuidValue ticketId,
  ) async {
    final assigneesList = <PlannerAssignee>[];
    final bucketMapsForTicket = await BucketTicketMap.db.find(
      session,
      where: (t) => t.ticketId.equals(ticketId),
      include: BucketTicketMap.include(
        bucket: Bucket.include(
          user: User.include(color: SystemColor.include()),
        ),
      ),
    );

    for (final ticketMap in bucketMapsForTicket) {
      final user = ticketMap.bucket?.user;
      if (user != null) {
        assigneesList.add(
          PlannerAssignee(
            userId: user.id!,
            userName: user.userName,
            color: user.color?.color ?? '#000000',
            selected: true,
          ),
        );
      }
    }
    return assigneesList;
  }

  /// Add or update a status
  Future<bool> addStatus(Session session, UuidValue? id, String name) async {
    if (id != null) {
      final status = await Status.db.findById(session, id);
      if (status != null) {
        status.statusName = name;
        await Status.db.updateRow(session, status);
        return true;
      }
    }
    await Status.db.insertRow(
      session,
      Status(statusName: name),
    );
    return true;
  }

  /// Add or update a priority
  Future<bool> addPriority(Session session, UuidValue? id, String name) async {
    if (id != null) {
      final priority = await Priority.db.findById(session, id);
      if (priority != null) {
        priority.priorityName = name;
        await Priority.db.updateRow(session, priority);
        return true;
      }
    }

    // Find max priority to append
    final priorities = await Priority.db.find(session, orderBy: (p) => p.priority);
    int nextOrder = 1;
    if (priorities.isNotEmpty) {
      nextOrder = priorities.last.priority + 1;
    }

    await Priority.db.insertRow(
      session,
      Priority(priorityName: name, priority: nextOrder),
    );
    return true;
  }

  /// Add or update a ticket type
  Future<bool> addTicketType(
    Session session,
    UuidValue? id,
    String name,
    UuidValue colorId,
  ) async {
    if (id != null) {
      final type = await TicketType.db.findById(session, id);
      if (type != null) {
        type.typeName = name;
        type.colorId = colorId;
        await TicketType.db.updateRow(session, type);
        return true;
      }
    }
    await TicketType.db.insertRow(
      session,
      TicketType(typeName: name, colorId: colorId),
    );
    return true;
  }

  /// Delete a planner variable (status, type, priority)
  Future<bool> deletePlannerVariable(
    Session session,
    String type,
    UuidValue id,
  ) async {
    if (type == 'status') {
      await Status.db.deleteWhere(session, where: (t) => t.id.equals(id));
    } else if (type == 'type') {
      await TicketType.db.deleteWhere(session, where: (t) => t.id.equals(id));
    } else if (type == 'priority') {
      await Priority.db.deleteWhere(session, where: (t) => t.id.equals(id));
    }
    return true;
  }

  /// Change priority order
  Future<bool> changePriority(
    Session session,
    UuidValue priorityId,
    int currentOrder,
    String direction,
  ) async {
    final priorities = await Priority.db.find(session, orderBy: (p) => p.priority);
    final index = priorities.indexWhere((p) => p.id == priorityId);
    if (index == -1) return false;

    if (direction == 'up' && index > 0) {
      final other = priorities[index - 1];
      final temp = priorities[index].priority;
      priorities[index].priority = other.priority;
      other.priority = temp;
      await Priority.db.updateRow(session, priorities[index]);
      await Priority.db.updateRow(session, other);
    } else if (direction == 'down' && index < priorities.length - 1) {
      final other = priorities[index + 1];
      final temp = priorities[index].priority;
      priorities[index].priority = other.priority;
      other.priority = temp;
      await Priority.db.updateRow(session, priorities[index]);
      await Priority.db.updateRow(session, other);
    }

    return true;
  }

  /// Get all planner activities for an app
  Future<GetPlannerActivitiesResponse> getPlannerActivities(
    Session session,
    UuidValue appId,
  ) async {
    // Check if app belongs to the same organization
    final user = await AuthHelper.getAuthenticatedUser(session);
    final app = await PlannerApp.db.findById(session, appId);
    if (app == null || app.organizationId != user.organizationId) {
      throw Exception('Unauthorized');
    }

    // Fetch activities for all tickets in this app
    final tickets = await Ticket.db.find(
      session,
      where: (t) => t.appId.equals(appId),
    );
    final ticketIds = tickets.map((t) => t.id!).toSet();

    if (ticketIds.isEmpty) {
      return GetPlannerActivitiesResponse(activities: []);
    }

    final activities = await PlannerActivity.db.find(
      session,
      where: (t) => t.ticketId.inSet(ticketIds),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );

    return GetPlannerActivitiesResponse(activities: activities);
  }

  Future<String?> _getLatestActivity(Session session, UuidValue ticketId) async {
    final activity = await PlannerActivity.db.findFirstRow(
      session,
      where: (t) => t.ticketId.equals(ticketId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
    if (activity == null) return null;
    if (activity.action == 'commented') {
      return "${activity.userName}: ${activity.details}";
    }
    return "${activity.userName} ${activity.action} ${activity.details ?? ''}".trim();
  }

  Future<bool> _hasNewActivity(
    Session session,
    UuidValue ticketId,
    UuidValue userId,
  ) async {
    final lastView = await TicketView.db.findFirstRow(
      session,
      where: (t) => t.ticketId.equals(ticketId) & t.userId.equals(userId),
    );

    if (lastView == null) return true; // Never viewed means new activity

    // Check comments after lastView.lastRead
    final latestComment = await TicketComment.db.findFirstRow(
      session,
      where: (t) =>
          t.ticketId.equals(ticketId) & (t.createdAt > lastView.lastRead),
    );
    if (latestComment != null) return true;

    // Check status changes after lastView.lastRead
    final latestStatusChange = await TicketStatusChange.db.findFirstRow(
      session,
      where: (t) =>
          t.ticketId.equals(ticketId) & (t.changedAt > lastView.lastRead),
    );
    if (latestStatusChange != null) return true;

    return false;
  }
}
