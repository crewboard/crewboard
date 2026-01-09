import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class GlassMorph extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double? width;
  final double? height;
  final double sigmaX;
  final double sigmaY;
  final Color color;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const GlassMorph({
    super.key,
    required this.child,
    this.borderRadius = 18.0,
    this.width,
    this.height,
    this.sigmaX = 20.0,
    this.sigmaY = 20.0,
    this.color = const Color(0x19000000),
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      final currentTheme = themeController.currentTheme;

      if (currentTheme == AppTheme.glass) {
        return SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: margin,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                child: Container(padding: padding, color: color, child: child),
              ),
            ),
          ),
        );
      } else {
        // Light or Dark Mode (Solid Design)
        final isDark = currentTheme == AppTheme.dark;
        final backgroundColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
        final borderColor = isDark
            ? Colors.white10
            : Colors.black.withValues(alpha: 0.1);

        return SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: margin,
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color: borderColor),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              child: child,
            ),
          ),
        );
      }
    });
  }
}
