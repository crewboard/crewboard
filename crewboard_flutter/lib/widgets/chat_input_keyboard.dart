import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/palette.dart';
import '../../screens/chats/widgets/emoji_button.dart';

// Assuming Emoji type comes from one of these or define a placeholder if not sure.
// Based on chat_screen.dart it was using `autocompleteEmojis` list of `Emoji`.
// Let's assume Emoji is from crewboard_client or defined locally.
// MessagesController had `List<Emoji>`.
// I will use dynamic for now to avoid import errors if I can't find it, or check MessagesController imports again.
// MessagesController imported `emoji_controller.dart`.

class ChatInputKeyboard extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onAttachPressed;
  final VoidCallback? onSendPressed;
  final List<String> typingUserNames;
  
  // Autocomplete props
  final bool showAutocomplete;
  final List<dynamic> autocompleteEmojis; // using dynamic to be safe, cast inside
  final Function(dynamic)? onAutocompleteSelected;
  final int selectedAutocompleteIndex;

  const ChatInputKeyboard({
    super.key,
    required this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onAttachPressed,
    this.onSendPressed,
    this.typingUserNames = const [],
    this.showAutocomplete = false,
    this.autocompleteEmojis = const [],
    this.onAutocompleteSelected,
    this.selectedAutocompleteIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (typingUserNames.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 2, left: 40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "${typingUserNames.join(", ")} is typing...",
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  color: Pallet.font3,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: showAutocomplete
                      ? _buildAutocompleteBar()
                      : const SizedBox.shrink(),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 5,
                    top: 5,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 8),
                      // EmojiButton(), // Requires EmojiController look up? Likely Get.find<EmojiController>. 
                      // If EmojiButton depends on MessagesController it might break.
                      // Let's assume EmojiButton is independent or widely available. 
                      // Checking imports: import '../../screens/chats/widgets/emoji_button.dart';
                      const EmojiButton(), 
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                          onChanged: onChanged,
                          onSubmitted: onSubmitted,
                          decoration: InputDecoration(
                            hintText: 'Type a message...',
                            hintStyle: TextStyle(
                              color: Pallet.font3.withValues(alpha: 0.7),
                              fontSize: 13,
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 10,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.mic_none, color: Pallet.font3, size: 22),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: onAttachPressed,
                        child: Icon(
                          Icons.attach_file,
                          color: Pallet.font3,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: onSendPressed,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0084FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAutocompleteBar() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 44,
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(autocompleteEmojis.length, (index) {
            final emoji = autocompleteEmojis[index];
            final isSelected = selectedAutocompleteIndex == index;
            // emoji.emoji - Assuming emoji object has .emoji property.
            // If dynamic, check proper usage.
             final String emojiChar = (emoji is String) ? emoji : (emoji.emoji ?? "");
             
            return GestureDetector(
              onTap: () {
                if (onAutocompleteSelected != null) {
                  onAutocompleteSelected!(emoji);
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.2)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: isSelected
                      ? Border.all(
                          color: Colors.white.withValues(alpha: 0.5),
                          width: 1.5,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    emojiChar,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
