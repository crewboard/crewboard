import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../config/palette.dart';
import '../../../widgets/widgets.dart';
import '../../../controllers/attendance_controller.dart';
import '../../../widgets/glass_morph.dart';
import './attendance_popup.dart';

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(attendanceProvider);
    final notifier = ref.read(attendanceProvider.notifier);

    if (state.isLoading && state.users.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPunchingModePanel(context, ref, state),
                  const SizedBox(width: 10),
                  _buildBiometricApiPanel(context, ref),
                  const SizedBox(width: 10),
                  _buildLeaveRequestsPanel(state),
                ],
              ),
              const SizedBox(height: 20),
              _buildAttendanceHeader(),
              Expanded(
                child: ListView.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, index) {
                    final user = state.users[index];
                    final attendance = notifier.getAttendanceForUser(user.id!);
                    return _buildUserAttendanceRow(context, ref, user, attendance);
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 15),
        _buildLeaveConfigsSidebar(context, ref, state),
      ],
    );
  }

  Widget _buildPunchingModePanel(BuildContext context, WidgetRef ref, AttendanceState state) {
    // Note: We don't have a specific 'setPunchingMode' yet in the notifier, 
    // but we can add it or handle it via a new state update if needed.
    // For now, I'll assume we can use the notifier to update state.
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
            _buildRadioOption("bio metric", "bio_metric", ref, state),
            _buildRadioOption("manual (user)", "manual_user", ref, state),
            _buildRadioOption("manual (hr)", "manual_hr", ref, state),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label, String value, WidgetRef ref, AttendanceState state) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: state.punchingMode,
          onChanged: (val) {
            // Updated logic to use notifier if we add a method, for now placeholder
          },
          activeColor: Colors.blue,
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildBiometricApiPanel(BuildContext context, WidgetRef ref) {
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
              onPress: () => ref.read(attendanceProvider.notifier).punch("manual_hr"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveRequestsPanel(AttendanceState state) {
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
                itemCount: state.leaveRequests.length,
                itemBuilder: (context, index) {
                  final request = state.leaveRequests[index];
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
                              ? Color(int.parse(request.user!.color!.color.replaceAll("#", "0xFF")))
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
                          color: request.accepted == true ? Colors.green : (request.accepted == false ? Colors.red : Colors.yellow),
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
          Expanded(flex: 3, child: Text("user", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("login time", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("logout time", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 2, child: Text("leave config", style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Widget _buildUserAttendanceRow(BuildContext context, WidgetRef ref, User user, Attendance? attendance) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Pallet.inside1,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                ProfileIcon(
                  size: 30,
                  name: user.userName,
                  color: user.color != null ? Color(int.parse(user.color!.color.replaceAll("#", "0xFF"))) : Colors.blue,
                ),
                const SizedBox(width: 10),
                Text(user.userName),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              attendance?.inTime != null ? DateFormat.jm().format(DateTime.parse(attendance!.inTime!)) : "--",
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              attendance?.outTime != null ? DateFormat.jm().format(DateTime.parse(attendance!.outTime!)) : "--",
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                if (user.leaveConfig != null)
                  InkWell(
                    onTap: () => viewLeaveConfig(context, ref, user.leaveConfig, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Pallet.inside2, borderRadius: BorderRadius.circular(10)),
                      child: Text(user.leaveConfig!.configName, style: const TextStyle(fontSize: 11)),
                    ),
                  )
                else
                  const Text("None", style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveConfigsSidebar(BuildContext context, WidgetRef ref, AttendanceState state) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Leave Configs", style: TextStyle(fontSize: 16, color: Pallet.font3)),
              AddButton(onPress: () => viewLeaveConfig(context, ref, null, false)),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: state.leaveConfigs.length,
              itemBuilder: (context, index) {
                final config = state.leaveConfigs[index];
                return InkWell(
                  onTap: () => viewLeaveConfig(context, ref, config, false),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(color: Pallet.inside1, borderRadius: BorderRadius.circular(10)),
                    child: Text(config.configName, style: const TextStyle(fontSize: 13)),
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
