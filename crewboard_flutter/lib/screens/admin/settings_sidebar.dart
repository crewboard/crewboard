import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/palette.dart';
import '../../controllers/admin_controller.dart';

class SettingsSidebar extends ConsumerWidget {
  const SettingsSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(adminProvider);
    final notifier = ref.read(adminProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 20),
        SideBarButton(
          label: 'General',
          isActive: currentPage == AdminPage.general,
          onTap: () => notifier.navigateTo(AdminPage.general),
          icon: Icons.settings,
        ),
        const SizedBox(height: 10),
        SideBarButton(
          label: 'Users',
          isActive: currentPage == AdminPage.users,
          onTap: () => notifier.navigateTo(AdminPage.users),
          icon: Icons.people,
        ),
        const SizedBox(height: 10),
        SideBarButton(
          label: 'Attendance',
          isActive: currentPage == AdminPage.attendance,
          onTap: () => notifier.navigateTo(AdminPage.attendance),
          icon: Icons.access_time,
        ),
        const SizedBox(height: 10),
        SideBarButton(
          label: 'Planner',
          isActive: currentPage == AdminPage.planner,
          onTap: () => notifier.navigateTo(AdminPage.planner),
          icon: Icons.event_note,
        ),
        const SizedBox(height: 10),
        SideBarButton(
          label: 'Documentation',
          isActive: currentPage == AdminPage.documentation,
          onTap: () => notifier.navigateTo(AdminPage.documentation),
          icon: Icons.description,
        ),
      ],
    );
  }
}

class SideBarButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final IconData icon;

  const SideBarButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isActive
              ? Pallet.font3.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: isActive
              ? Border.all(color: Pallet.font3.withValues(alpha: 0.5))
              : Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isActive ? Colors.white : Pallet.font3,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Pallet.font3,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
