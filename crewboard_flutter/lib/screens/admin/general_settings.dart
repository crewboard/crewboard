import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/palette.dart';
import '../../controllers/theme_controller.dart';
import '../../main.dart'; // For sessionManager access if needed, or just use singleton

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'General Settings',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Pallet.font1,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Pallet.inside1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Pallet.font1,
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                onPressed: () async {
                  await sessionManager.signOutDevice();
                  Get.offAllNamed('/'); // Navigate to root/login
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Theming Section
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Pallet.inside1,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theming',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Pallet.font1,
                ),
              ),
              const SizedBox(height: 15),
              GetX<ThemeController>(
                builder: (controller) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: const Color(0xFF2C3E50),
                    ),
                    child: DropdownButton<AppTheme>(
                      value: controller.currentTheme,
                      dropdownColor: const Color(0xFF2C3E50),
                      style: const TextStyle(color: Colors.white),
                      iconEnabledColor: Colors.white,
                      underline: Container(
                        height: 2,
                        color: Colors.blueAccent,
                      ),
                      onChanged: (AppTheme? newValue) {
                        if (newValue != null) {
                          controller.setTheme(newValue);
                        }
                      },
                      items: AppTheme.values.map<DropdownMenuItem<AppTheme>>(
                        (AppTheme value) {
                          return DropdownMenuItem<AppTheme>(
                            value: value,
                            child: Text(
                              value == AppTheme.glass
                                  ? 'Glass Morphism'
                                  : value == AppTheme.light
                                  ? 'Light Mode'
                                  : 'Dark Mode',
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
