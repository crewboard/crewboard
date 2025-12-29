import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_controller.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is available
    final AdminController controller = Get.put(AdminController());

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Obx(() => controller.currentPageWidget),
    );
  }
}
