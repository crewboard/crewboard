import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../main.dart'; // Access to client

class AttendanceController extends GetxController {
  RxList<User> users = <User>[].obs;
  RxList<Attendance> attendanceRecords = <Attendance>[].obs;
  RxList<LeaveConfig> leaveConfigs = <LeaveConfig>[].obs;
  RxList<LeaveRequest> leaveRequests = <LeaveRequest>[].obs;

  RxBool isLoading = false.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString punchingMode = 'manual_hr'.obs;

  @override
  void onInit() {
    super.onInit();
    loadAttendanceData();
  }

  Future<void> loadAttendanceData() async {
    isLoading.value = true;
    try {
      final response = await client.admin.getAttendanceData(selectedDate.value);
      users.value = response.users;
      attendanceRecords.value = response.attendance;
      leaveConfigs.value = response.configs;
      leaveRequests.value = response.requests;

      final sysVars = await client.admin.getSystemVariables();
      if (sysVars != null) {
        punchingMode.value = sysVars.punchingMode;
      }
    } catch (e) {
      print("Error loading attendance data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Attendance? getAttendanceForUser(UuidValue userId) {
    try {
      return attendanceRecords.firstWhere((record) => record.userId == userId);
    } catch (e) {
      return null;
    }
  }

  Future<void> saveLeaveConfig(LeaveConfig config) async {
    try {
      await client.admin.saveLeaveConfig(config);
      await loadAttendanceData(); // Refresh
    } catch (e) {
      print("Error saving leave config: $e");
    }
  }

  Future<void> punch(String mode) async {
    try {
      await client.admin.punch(mode);
      await loadAttendanceData(); // Refresh
    } catch (e) {
      print("Error punching: $e");
      Get.snackbar("Error", e.toString());
    }
  }
}
