import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:collection/collection.dart';
import '../main.dart'; // Access to client

class AttendanceState {
  final List<User> users;
  final List<Attendance> attendanceRecords;
  final List<LeaveConfig> leaveConfigs;
  final List<LeaveRequest> leaveRequests;
  final bool isLoading;
  final DateTime selectedDate;
  final String punchingMode;

  AttendanceState({
    this.users = const [],
    this.attendanceRecords = const [],
    this.leaveConfigs = const [],
    this.leaveRequests = const [],
    this.isLoading = false,
    DateTime? selectedDate,
    this.punchingMode = 'manual_hr',
  }) : selectedDate = selectedDate ?? DateTime.now();

  AttendanceState copyWith({
    List<User>? users,
    List<Attendance>? attendanceRecords,
    List<LeaveConfig>? leaveConfigs,
    List<LeaveRequest>? leaveRequests,
    bool? isLoading,
    DateTime? selectedDate,
    String? punchingMode,
  }) {
    return AttendanceState(
      users: users ?? this.users,
      attendanceRecords: attendanceRecords ?? this.attendanceRecords,
      leaveConfigs: leaveConfigs ?? this.leaveConfigs,
      leaveRequests: leaveRequests ?? this.leaveRequests,
      isLoading: isLoading ?? this.isLoading,
      selectedDate: selectedDate ?? this.selectedDate,
      punchingMode: punchingMode ?? this.punchingMode,
    );
  }
}

final attendanceProvider = NotifierProvider<AttendanceNotifier, AttendanceState>(AttendanceNotifier.new);

class AttendanceNotifier extends Notifier<AttendanceState> {
  @override
  AttendanceState build() {
    Future.microtask(() => loadAttendanceData());
    return AttendanceState();
  }

  Future<void> loadAttendanceData() async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await client.admin.getAttendanceData(state.selectedDate);
      final sysVars = await client.admin.getSystemVariables();
      
      state = state.copyWith(
        users: response.users,
        attendanceRecords: response.attendance,
        leaveConfigs: response.configs,
        leaveRequests: response.requests,
        punchingMode: sysVars?.punchingMode ?? 'manual_hr',
        isLoading: false,
      );
    } catch (e) {
      print("Error loading attendance data: $e");
      state = state.copyWith(isLoading: false);
    }
  }

  Attendance? getAttendanceForUser(UuidValue userId) {
    return state.attendanceRecords.firstWhereOrNull((record) => record.userId == userId);
  }

  void setSelectedDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
    loadAttendanceData();
  }

  Future<void> saveLeaveConfig(LeaveConfig config) async {
    try {
      await client.admin.saveLeaveConfig(config);
      await loadAttendanceData(); 
    } catch (e) {
      print("Error saving leave config: $e");
    }
  }

  Future<void> punch(String mode) async {
    try {
      await client.admin.punch(mode);
      await loadAttendanceData(); 
    } catch (e) {
      print("Error punching: $e");
    }
  }
}
