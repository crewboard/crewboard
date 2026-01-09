import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';

class PlannerBotController extends GetxController {
  final RxList<PlannerNotification> notifications = <PlannerNotification>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadMockNotifications();
  }

  void loadMockNotifications() {
    notifications.assignAll([
      PlannerNotification(
        notification: "John Doe created a new ticket: 'Fix Login Bug'",
        notificationType: "ticket_created",
        ticketId: UuidValue.fromString('00000000-0000-4000-8000-000000000001'),
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000002'),
        seenUserList: [],
      ),
      PlannerNotification(
        notification: "You were assigned to 'Implement Dashboard'",
        notificationType: "ticket_assigned",
        ticketId: UuidValue.fromString('00000000-0000-4000-8000-000000000003'),
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000004'),
        seenUserList: [],
      ),
      PlannerNotification(
        notification: "Ticket 'Update Assets' moved to 'Done'",
        notificationType: "ticket_updated",
        ticketId: UuidValue.fromString('00000000-0000-4000-8000-000000000005'),
        userId: UuidValue.fromString('00000000-0000-4000-8000-000000000006'),
        seenUserList: [],
      ),
    ]);
  }
}
