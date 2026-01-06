import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../config/palette.dart';
import '../../../widgets/widgets.dart';
import '../../../controllers/attendance_controller.dart';
import '../../../widgets/glass_morph.dart';
import './attendance_popup.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AttendanceController());

    return Obx(() {
      if (controller.isLoading.value && controller.users.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main Content (Attendance and Performance)
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Attendance",
                  style: TextStyle(fontSize: 16, color: Pallet.font3),
                ),
                const SizedBox(height: 10),
                // Top Widgets (Punching Mode, Biometric API, Leave Requests)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Punching Mode
                    _buildPunchingModePanel(controller),
                    const SizedBox(width: 10),
                    // Biometric API
                    _buildBiometricApiPanel(),
                    const SizedBox(width: 10),
                    // Leave Requests
                    _buildLeaveRequestsPanel(controller),
                  ],
                ),
                const SizedBox(height: 20),
                // Attendance Table Header
                _buildAttendanceHeader(),
                // Attendance List
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final user = controller.users[index];
                      final attendance = controller.getAttendanceForUser(
                        user.id!,
                      );
                      return _buildUserAttendanceRow(context, user, attendance);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          // Sidebar (Leave Configs)
          _buildLeaveConfigsSidebar(context, controller),
        ],
      );
    });
  }

  Widget _buildPunchingModePanel(AttendanceController controller) {
    return Expanded(
      child: GlassMorph(
        height: 150,
        padding: const EdgeInsets.all(10),
        borderRadius: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("punching mode", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            _buildRadioOption("bio metric", "bio_metric", controller),
            _buildRadioOption("manual (user)", "manual_user", controller),
            _buildRadioOption("manual (hr)", "manual_hr", controller),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(
    String label,
    String value,
    AttendanceController controller,
  ) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: controller.punchingMode.value,
          onChanged: (val) {
            if (val != null) controller.punchingMode.value = val;
          },
          activeColor: Colors.blue,
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildBiometricApiPanel() {
    return Expanded(
      child: GlassMorph(
        height: 150,
        padding: const EdgeInsets.all(10),
        borderRadius: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("bio metric api", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Pallet.inside3,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Text(
                "{server_url}/punching?punchId={id}",
                style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
              ),
            ),
            const SizedBox(height: 10),
            SmallButton(
              label: "Punch Test",
              onPress: () =>
                  Get.find<AttendanceController>().punch("manual_hr"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveRequestsPanel(AttendanceController controller) {
    return Expanded(
      child: GlassMorph(
        height: 150,
        padding: const EdgeInsets.all(10),
        borderRadius: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("leave requests", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                itemCount: controller.leaveRequests.length,
                itemBuilder: (context, index) {
                  final request = controller.leaveRequests[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Pallet.inside3,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        ProfileIcon(
                          size: 20,
                          name: request.user?.userName ?? "?",
                          color: request.user?.color != null
                              ? Color(
                                  int.parse(
                                    request.user!.color!.color.replaceAll(
                                      "#",
                                      "0xFF",
                                    ),
                                  ),
                                )
                              : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            request.user?.userName ?? "Unknown",
                            style: const TextStyle(fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: request.accepted == true
                              ? Colors.green
                              : (request.accepted == false
                                    ? Colors.red
                                    : Colors.yellow),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: const Row(
        children: [
          Expanded(
            flex: 3,
            child: Text("user", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "login time",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "logout time",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "leave config",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAttendanceRow(
    BuildContext context,
    User user,
    Attendance? attendance,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Pallet.inside1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // User Info
          Expanded(
            flex: 3,
            child: Row(
              children: [
                ProfileIcon(
                  size: 30,
                  name: user.userName,
                  color: user.color != null
                      ? Color(
                          int.parse(user.color!.color.replaceAll("#", "0xFF")),
                        )
                      : Colors.blue,
                ),
                const SizedBox(width: 10),
                Text(user.userName),
              ],
            ),
          ),
          // Login Time
          Expanded(
            flex: 2,
            child: Text(
              attendance?.inTime != null
                  ? DateFormat.jm().format(DateTime.parse(attendance!.inTime!))
                  : "--",
              style: const TextStyle(fontSize: 13),
            ),
          ),
          // Logout Time
          Expanded(
            flex: 2,
            child: Text(
              attendance?.outTime != null
                  ? DateFormat.jm().format(DateTime.parse(attendance!.outTime!))
                  : "--",
              style: const TextStyle(fontSize: 13),
            ),
          ),
          // Leave Config Badge
          Expanded(
            flex: 2,
            child: Row(
              children: [
                if (user.leaveConfig != null)
                  InkWell(
                    onTap: () =>
                        viewLeaveConfig(context, user.leaveConfig, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Pallet.inside2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        user.leaveConfig!.configName,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                  )
                else
                  const Text(
                    "None",
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveConfigsSidebar(
    BuildContext context,
    AttendanceController controller,
  ) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Leave Configs",
                style: TextStyle(fontSize: 16, color: Pallet.font3),
              ),
              AddButton(onPress: () => viewLeaveConfig(context, null, false)),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: controller.leaveConfigs.length,
              itemBuilder: (context, index) {
                final config = controller.leaveConfigs[index];
                return InkWell(
                  onTap: () => viewLeaveConfig(context, config, false),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Pallet.inside1,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      config.configName,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
