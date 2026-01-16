import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../utils.dart';

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
      throw Exception('Unauthorized access to app');
    }

    final userId = user.id!;

    // Fetch buckets for user and app
    final buckets = await Bucket.db.find(
      session,
      where: (t) => (t.userId.equals(userId)) & (t.appId.equals(appIdVal)),
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
        ),
      );
    }

    // Default flows - Placeholder data
    final flows = [
      FlowModel(
        appId: UuidValue.fromString('00000000-0000-4000-8000-000000000000'),
        name: 'Default Flow',
        flow: '{}',
        lastUpdated: DateTime.now(),
      )..id = UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
      FlowModel(
        appId: UuidValue.fromString('00000000-0000-4000-8000-000000000000'),
        name: 'Bug Fix Flow',
        flow: '{}',
        lastUpdated: DateTime.now(),
      )..id = UuidValue.fromString('00000000-0000-4000-8000-000000000002'),
    ];

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

    // Map to bucket
    await BucketTicketMap.db.insertRow(
      session,
      BucketTicketMap(
        bucketId: request.bucketId,
        ticketId: ticket.id!,
        order: 1, // Default to first
      ),
    );

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

    // Update order in new bucket
    final newBucketMaps = await BucketTicketMap.db.find(
      session,
      where: (t) => t.bucketId.equals(newBucketId),
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
        order: request.newOrder,
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
    UuidValue ticketId,
    List<Map<String, dynamic>> updates,
  ) async {
    final user = await AuthHelper.getAuthenticatedUser(session);
    final ticket = await Ticket.db.findById(session, ticketId);
    if (ticket == null) return false;

    // TODO: Verify authorization

    for (final update in updates) {
      final name = update['name'] as String;
      final value = update['value'];

      if (name == 'statusId') {
        final newStatusId = UuidValue.fromString(value as String);
        if (ticket.statusId != newStatusId) {
          final oldStatusId = ticket.statusId;
          ticket.statusId = newStatusId;
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
                  'from ${ticket.status?.statusName ?? 'None'} to ${newStatus?.statusName ?? 'Unknown'}',
              createdAt: DateTime.now(),
            ),
          );
        }
      } else if (name == 'ticketName') {
        ticket.ticketName = value as String;
      } else if (name == 'ticketBody') {
        ticket.ticketBody = value as String;
      } else if (name == 'creds') {
        ticket.creds = int.tryParse(value.toString()) ?? 0;
      } else if (name == 'deadline') {
        ticket.deadline = DateTime.tryParse(value.toString());
      }
    }

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
