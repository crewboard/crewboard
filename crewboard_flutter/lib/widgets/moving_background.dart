import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:particles_flutter/particles_flutter.dart';
import '../controllers/theme_controller.dart';

class MovingBackground extends StatelessWidget {
  const MovingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final currentTheme = themeController.currentTheme;
      
      // Determine if it's a glass theme
      final isGlass = currentTheme == AppTheme.glassDark || 
                      currentTheme == AppTheme.glassLight;
      
      // Determine if it's a light theme
      final isLight = currentTheme == AppTheme.glassLight || 
                      currentTheme == AppTheme.classicLight;

      if (isGlass) {
        // Glass themes with moving particles
        return Stack(
          children: [
            Container(
              color: isLight ? Colors.white : Colors.black,
            ),
            CircularParticle(
              key: UniqueKey(),
              awayRadius: 120,
              numberOfParticles: 10,
              speedOfParticles: 3,
              height: height,
              width: width,
              onTapAnimation: false,
              maxParticleSize: 300,
              isRandSize: true,
              isRandomColor: true,
              randColorList: isLight
                  ? const [
                      Color(0xFF5292f6),
                      Color(0xFF834bac),
                      Color(0xFFde7bb1),
                    ]
                  : const [
                      Color(0xFF002772),
                      Color(0xFF5c0057),
                      Color(0xFF00283f),
                    ],
              enableHover: false,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                tileMode: TileMode.repeated,
                sigmaX: 80,
                sigmaY: 80,
              ),
              child: Container(
                color: isLight 
                    ? Colors.white.withOpacity(0.5)
                    : Colors.black.withOpacity(0.5),
              ),
            ),
          ],
        );
      } else {
        // Classic themes with solid background
        return Container(
          color: isLight ? Colors.white : const Color(0xFF1E1E1E),
        );
      }
    });
  }
}
