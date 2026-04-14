import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/theme_controller.dart';

class GlassMorph extends ConsumerWidget {
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
    this.color = const Color.fromARGB(36, 0, 0, 0),
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeProvider);

    return themeAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (e, s) => const SizedBox.shrink(),
      data: (currentTheme) {
        if (currentTheme == AppTheme.glassDark ||
            currentTheme == AppTheme.glassLight) {
          return SizedBox(
            width: width,
            height: height,
            child: Padding(
              padding: margin,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                  child: Container(
                    padding: padding,
                    color: color,
                    child: child,
                  ),
                ),
              ),
            ),
          );
        } else {
          // Classic Light or Dark Mode (Solid Design)
          final isDark = currentTheme == AppTheme.classicDark;
          final backgroundColor = isDark
              ? const Color(0xFF1E1E1E)
              : Colors.white;
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
                  boxShadow: [
                    if (!isDark)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
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
      },
    );
  }
}
