import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class PlannerEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Get planner data (buckets with tickets) for an app
  Future<GetPlannerDataResponse> getPlannerData(
    Session session,
    int appId,
  ) async {
    // TODO: Resolve auth extension issue in Serverpod 3.1
    // Using placeholder userId 1 for initial development/seeding
    const userId = 1;

    // Fetch buckets for user and app
    final buckets = await Bucket.db.find(
      session,
      where: (t) => (t.userId.equals(userId)) & (t.appId.equals(appId)),
    );

    if (buckets.isEmpty) {
      return GetPlannerDataResponse(buckets: []);
    }

    // For each bucket, fetch tickets
    final bucketsWithTickets = <BucketModel>[];

    for (final bucket in buckets) {
      // Get bucket-ticket mappings for this bucket
      final bucketTicketMaps = await BucketTicketMap.db.find(
        session,
        where: (t) => t.bucketId.equals(bucket.id!),
        orderBy: (t) => t.order,
      );

      final ticketIds = bucketTicketMaps.map((m) => m.ticketId).toSet();

      if (ticketIds.isEmpty) {
        bucketsWithTickets.add(
          BucketModel(
            bucketId: bucket.id!,
            bucketName: bucket.bucketName,
            tickets: [],
          ),
        );
        continue;
      }

      // Fetch tickets
      final tickets = await Ticket.db.find(
        session,
        where: (t) => t.id.inSet(ticketIds),
      );

      // Fetch related data for tickets
      final ticketModels = <PlannerTicket>[];
      for (final ticket in tickets) {
        // Fetch status
        final status = await Status.db.findById(session, ticket.statusId);

        // Fetch priority
        final priority = await Priority.db.findById(session, ticket.priorityId);

        // Fetch ticket type
        final ticketType = await TicketType.db.findById(session, ticket.typeId);

        // Fetch color for ticket type
        String typeColor = '#000000';
        if (ticketType != null) {
          final color = await SystemColor.db.findById(
            session,
            ticketType.colorId,
          );
          if (color != null) {
            typeColor = color.color;
          }
        }

        // Fetch assignees for this ticket
        final assigneesList = <PlannerAssignee>[];
        final bucketMapsForTicket = await BucketTicketMap.db.find(
          session,
          where: (t) => t.ticketId.equals(ticket.id!),
        );

        for (final map in bucketMapsForTicket) {
          final assigneeBucket = await Bucket.db.findById(
            session,
            map.bucketId,
          );
          if (assigneeBucket != null) {
            final user = await User.db.findById(session, assigneeBucket.userId);
            if (user != null) {
              final userColor = await SystemColor.db.findById(
                session,
                user.colorId,
              );
              assigneesList.add(
                PlannerAssignee(
                  userId: user.id!,
                  userName: user.userName,
                  color: userColor?.color ?? '#000000',
                  selected: true,
                ),
              );
            }
          }
        }

        ticketModels.add(
          PlannerTicket(
            id: ticket.id!,
            ticketName: ticket.ticketName,
            ticketBody: ticket.ticketBody,
            statusName: status?.statusName ?? 'Unknown',
            priorityName: priority?.priorityName ?? '',
            typeName: ticketType?.typeName ?? '',
            typeColor: typeColor,
            deadline: ticket.deadline?.toIso8601String(),
            assignees: assigneesList,
            holder: 'Unknown',
            creds: ticket.creds.toDouble(),
          ),
        );
      }

      bucketsWithTickets.add(
        BucketModel(
          bucketId: bucket.id!,
          bucketName: bucket.bucketName,
          tickets: ticketModels,
        ),
      );
    }

    return GetPlannerDataResponse(buckets: bucketsWithTickets);
  }

  /// Fetch initial data for "Add Ticket" form
  Future<GetAddTicketDataResponse> getAddTicketData(
    Session session,
  ) async {
    final users = await User.db.find(session);
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

    // Default flows
    final flows = [
      FlowModel(flowId: 1, flowName: 'Default Flow'),
      FlowModel(flowId: 2, flowName: 'Bug Fix Flow'),
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
    const userId = 1; // TODO: Fix

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
        checklist: '',
        flows: request.ticket.flows ?? '',
        creds: request.ticket.creds.toInt(),
        deadline: deadline,
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

    return true;
  }

  /// Search/list all tickets in project
  Future<GetAllTicketsResponse> getAllTickets(
    Session session,
    int appId,
  ) async {
    final tickets = await Ticket.db.find(
      session,
      where: (t) => t.appId.equals(appId),
    );

    final ticketModels = <PlannerTicket>[];
    for (final ticket in tickets) {
      final status = await Status.db.findById(session, ticket.statusId);
      final priority = await Priority.db.findById(session, ticket.priorityId);
      final ticketType = await TicketType.db.findById(session, ticket.typeId);

      String typeColor = '#000000';
      if (ticketType != null) {
        final color = await SystemColor.db.findById(
          session,
          ticketType.colorId,
        );
        typeColor = color?.color ?? '#000000';
      }

      ticketModels.add(
        PlannerTicket(
          id: ticket.id!,
          ticketName: ticket.ticketName,
          ticketBody: ticket.ticketBody,
          statusName: status?.statusName ?? 'Unknown',
          priorityName: priority?.priorityName ?? '',
          typeName: ticketType?.typeName ?? '',
          typeColor: typeColor,
          deadline: ticket.deadline?.toIso8601String(),
          assignees:
              [], // Fetching assignees for all tickets might be heavy, skipping for now
          holder: 'Unknown',
          creds: ticket.creds.toDouble(),
        ),
      );
    }

    return GetAllTicketsResponse(tickets: ticketModels);
  }

  /// Get detailed ticket data
  Future<GetTicketDataResponse> getTicketData(
    Session session,
    int ticketId,
  ) async {
    final ticket = await Ticket.db.findById(session, ticketId);
    if (ticket == null) {
      throw Exception('Ticket not found');
    }

    final status = await Status.db.findById(session, ticket.statusId);
    final priority = await Priority.db.findById(session, ticket.priorityId);
    final ticketType = await TicketType.db.findById(session, ticket.typeId);

    String typeColor = '#000000';
    if (ticketType != null) {
      final color = await SystemColor.db.findById(session, ticketType.colorId);
      typeColor = color?.color ?? '#000000';
    }

    // Fetch assignees
    final assigneesList = <UserModel>[];
    final mapsForTicket = await BucketTicketMap.db.find(
      session,
      where: (t) => t.ticketId.equals(ticket.id!),
    );

    for (final map in mapsForTicket) {
      final bucket = await Bucket.db.findById(session, map.bucketId);
      if (bucket != null) {
        final user = await User.db.findById(session, bucket.userId);
        if (user != null) {
          final userColor = await SystemColor.db.findById(
            session,
            user.colorId,
          );
          assigneesList.add(
            UserModel(
              userId: user.id!,
              userName: user.userName,
              color: userColor?.color ?? '#000000',
              selected: false,
            ),
          );
        }
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
        statusId: status?.id ?? 0,
        statusName: status?.statusName ?? '',
      ),
      priority: PriorityModel(
        priorityId: priority?.id ?? 0,
        priorityName: priority?.priorityName ?? '',
        priority: priority?.priority ?? 0,
      ),
      type: TypeModel(
        typeId: ticketType?.id ?? 0,
        typeName: ticketType?.typeName ?? '',
        color: typeColor,
      ),
      checklist: [], // TODO: Parse checklist
      flows: ticket.flows,
      deadline: formattedDeadline,
      creds: ticket.creds.toDouble(),
      assignees: assigneesList,
      attachments: attachmentModels,
    );

    return GetTicketDataResponse(ticket: ticketModel);
  }

  /// Get comments for a ticket
  Future<GetTicketCommentsResponse> getTicketComments(
    Session session,
    int ticketId,
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
    const userId = 1; // TODO: Fix

    await TicketComment.db.insertRow(
      session,
      TicketComment(
        ticketId: request.ticketId,
        userId: userId,
        message: request.message,
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
    const userId = 1; // TODO: Fix

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

    return true;
  }
}
