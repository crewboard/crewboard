import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/palette.dart';
import '../../controllers/admin_controller.dart';

class SettingsSidebar extends StatelessWidget {
  const SettingsSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is available
    final AdminController controller = Get.put(AdminController());

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
        Obx(
          () => SideBarButton(
            label: 'General',
            isActive: controller.currentPage.value == AdminPage.general,
            onTap: () => controller.navigateTo(AdminPage.general),
            icon: Icons.settings,
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => SideBarButton(
            label: 'Users',
            isActive: controller.currentPage.value == AdminPage.users,
            onTap: () => controller.navigateTo(AdminPage.users),
            icon: Icons.people,
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => SideBarButton(
            label: 'Attendance',
            isActive: controller.currentPage.value == AdminPage.attendance,
            onTap: () => controller.navigateTo(AdminPage.attendance),
            icon: Icons.access_time,
          ),
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
