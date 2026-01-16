import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../config/palette.dart';
import '../controllers/rooms_controller.dart';

class BotItem extends StatelessWidget {
  final String name;
  final String image;
  final String page;
  final int count;

  const BotItem({
    super.key,
    required this.name,
    required this.image,
    required this.page,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = Window.subPage.value == page;

      return InkWell(
        onTap: () {
          // Clear selected room via controller
          try {
            Get.find<RoomsController>().selectedRoom.value = null;
          } catch (_) {}
          Window.subPage.value = page;
          refreshSink.add("");
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? Pallet.inside1 : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(
                name.toLowerCase() == "threads" ||
                        name.toLowerCase() == "planner"
                    ? Icons.alternate_email
                    : Icons.memory,
                color: isSelected ? Colors.white : Pallet.font3,
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 14,
                    color: isSelected ? Colors.white : Pallet.font1,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              if (count != 0)
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: Center(
                    child: Text(
                      count.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
