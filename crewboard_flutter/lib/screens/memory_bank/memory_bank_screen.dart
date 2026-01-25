import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/palette.dart';
import '../../widgets/glass_morph.dart';
import '../chats/chat_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MemoryBankScreen extends StatelessWidget {
  const MemoryBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for memories
    final memories = [
      {
        'title': 'Meeting Notes',
        'body': 'Discussed the project timeline and milestones.',
      },
      {
        'title': 'Idea for UI',
        'body':
            'Use glassmorphism for the memory bank to match the chat theme.',
      },
      {
        'title': 'Todo',
        'body': 'Implement the addMemory functionality in the next session.',
      },
    ].obs;

    return GlassMorph(
      borderRadius: 24,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: 15,
              left: 20,
              right: 20,
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                const Icon(Icons.memory, color: Colors.blue, size: 32),
                const SizedBox(width: 12),
                Text(
                  "Memory Bank",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.blue),
                  onPressed: () {
                    // TODO: Implement addMemory dialog
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: memories.length,
                itemBuilder: (context, index) {
                  final memory = memories[index];
                  return MemoryListItem(
                    title: memory['title'] ?? '',
                    body: memory['body'] ?? '',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MemoryListItem extends StatelessWidget {
  final String title;
  final String body;

  const MemoryListItem({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            body,
            style: TextStyle(
              fontSize: 13,
              color: Pallet.font3,
            ),
          ),
        ],
      ),
    );
  }
}
