import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuNotifier extends Notifier<OverlayEntry?> {
  @override
  OverlayEntry? build() {
    ref.onDispose(() {
      state?.remove();
    });
    return null;
  }

  void show(BuildContext context, OverlayEntry entry) {
    // Remove existing menu if any. This ensures mutual exclusivity.
    if (state != null) {
      try {
        state?.remove();
      } catch (e) {
        // Fallback if already removed or not mounted
      }
    }

    state = entry;
    Overlay.of(context).insert(state!);
  }

  void close() {
    if (state != null) {
      try {
        state?.remove();
      } catch (e) {
        // Fallback
      }
      state = null;
    }
  }
}

final menuProvider = NotifierProvider<MenuNotifier, OverlayEntry?>(
  MenuNotifier.new,
);
