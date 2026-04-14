import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../controllers/admin_controller.dart';

class AdminScreen extends ConsumerWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageWidget = ref.watch(adminPageWidgetProvider);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: currentPageWidget,
    );
  }
}
