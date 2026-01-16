import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:particles_flutter/particles_flutter.dart';
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
        const SizedBox(height: 30),
        // Theming Section
        Text(
          'Themes',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Pallet.font1,
          ),
        ),
        const SizedBox(height: 15),
        GetX<ThemeController>(
          builder: (controller) {
            return Wrap(
              spacing: 15,
              runSpacing: 15,
              children: AppTheme.values.map((theme) {
                final isSelected = controller.currentTheme == theme;
                
                // Define preview colors based on theme
                Color previewBg;
                Color previewAccent;
                Color textColor;
                bool isGlass;
                
                switch (theme) {
                  case AppTheme.glassDark:
                    previewBg = Colors.black.withOpacity(0.3);
                    previewAccent = Colors.white.withOpacity(0.2);
                    textColor = Colors.white;
                    isGlass = true;
                    break;
                  case AppTheme.glassLight:
                    previewBg = Colors.white.withOpacity(0.3);
                    previewAccent = Colors.black.withOpacity(0.1);
                    textColor = Colors.black87;
                    isGlass = true;
                    break;
                  case AppTheme.classicLight:
                    previewBg = Colors.white;
                    previewAccent = Colors.grey.shade200;
                    textColor = Colors.black87;
                    isGlass = false;
                    break;
                  case AppTheme.classicDark:
                    previewBg = const Color(0xFF1E1E1E);
                    previewAccent = const Color(0xFF2D2D2D);
                    textColor = Colors.white;
                    isGlass = false;
                    break;
                }
                
                return GestureDetector(
                  onTap: () => controller.setTheme(theme),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 180,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected 
                              ? Colors.blueAccent 
                              : (isGlass 
                                  ? Colors.white.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.3)),
                          width: isSelected ? 3 : 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          // Background layer
                          if (isGlass) ...[
                            // White base layer for glass light theme
                            if (theme == AppTheme.glassLight)
                              Positioned.fill(
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                            // Moving bubble background for glass themes
                            Positioned.fill(
                              child: CircularParticle(
                                key: UniqueKey(),
                                awayRadius: 40,
                                numberOfParticles: 3,
                                speedOfParticles: 1,
                                height: 120,
                                width: 180,
                                onTapAnimation: false,
                                maxParticleSize: 80,
                                isRandSize: true,
                                isRandomColor: true,
                                randColorList: theme == AppTheme.glassDark
                                    ? const [
                                        Color(0xFF002772),
                                        Color(0xFF5c0057),
                                        Color(0xFF00283f),
                                      ]
                                    : const [
                                        Color(0xFF5292f6),
                                        Color(0xFF834bac),
                                        Color(0xFFde7bb1),
                                      ],
                                enableHover: false,
                              ),
                            ),
                            // Blur effect
                            Positioned.fill(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(
                                  sigmaX: 30,
                                  sigmaY: 30,
                                ),
                                child: Container(
                                  color: theme == AppTheme.glassDark
                                      ? Colors.black.withOpacity(0.5)
                                      : Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ] else ...[
                            // Solid background for classic themes
                            Positioned.fill(
                              child: Container(
                                color: previewBg,
                              ),
                            ),
                          ],
                          // Preview elements to show the theme style
                          Positioned(
                            top: 35,
                            left: 15,
                            child: Container(
                              width: 50,
                              height: 8,
                              decoration: BoxDecoration(
                                color: previewAccent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50,
                            left: 15,
                            child: Container(
                              width: 70,
                              height: 8,
                              decoration: BoxDecoration(
                                color: previewAccent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 65,
                            left: 15,
                            child: Container(
                              width: 40,
                              height: 8,
                              decoration: BoxDecoration(
                                color: previewAccent,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 15,
                            right: 15,
                            child: Container(
                              width: 35,
                              height: 25,
                              decoration: BoxDecoration(
                                color: previewAccent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ),
                          // Theme name - top left (on top of background)
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Text(
                              controller.getThemeName(theme),
                              style: TextStyle(
                                color: textColor,
                                fontSize: 11,
                                fontWeight:  FontWeight.bold 
                              ),
                            ),
                          ),
                          // Checkbox - top right (on top of background)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Icon(
                              isSelected 
                                  ? Icons.check_circle 
                                  : Icons.circle_outlined,
                              color: isSelected 
                                  ? Colors.blueAccent 
                                  : textColor.withOpacity(0.4),
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
