import 'package:flutter/material.dart';
import '../../config/palette.dart';
import '../../widgets/glass_morph.dart';
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
    ];

    return GlassMorph(
      borderRadius: 24,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
            child: Row(
              children: [
                Text(
                  "Memory",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Pallet.font1,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    // TODO: Implement addMemory dialog
                  },
                ),
              ],
            ),
          ),
          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     // Divider(color: Colors.white.withValues(alpha: 0.1)),
          //     Container(
          //       padding: const EdgeInsets.symmetric(horizontal: 12),
          //       color: const Color(0xff121212),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Icon(
          //             Icons.keyboard_arrow_down,
          //             size: 16,
          //             color: Pallet.font3,
          //           ),
          //           const SizedBox(width: 4),
          //           Text(
          //             "Saved Memories",
          //             style: GoogleFonts.poppins(
          //               fontSize: 12,
          //               color: Pallet.font3,
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
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
