import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../controllers/giphy_controller.dart';
import '../../../controllers/messages_controller.dart';
import '../../../config/palette.dart';
import '../../../widgets/glass_morph.dart';
import '../../../widgets/text_box.dart';
import 'emoji_picker_widget.dart';

enum PickerTab { emoji, gifs, stickers }

class ChatPicker extends StatefulWidget {
  const ChatPicker({super.key});

  @override
  State<ChatPicker> createState() => _ChatPickerState();
}

class _ChatPickerState extends State<ChatPicker> {
  final GiphyController giphyController = Get.find<GiphyController>();
  final MessagesController messagesController = Get.find<MessagesController>();
  final TextEditingController searchController = TextEditingController();
  PickerTab selectedTab = PickerTab.emoji;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return GlassMorph(
      width: 400,
      height: 350,
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: SmallTextBox(
              controller: searchController,
              hintText: "search",
              onType: (value) {
                setState(() {
                  searchQuery = value;
                });
                if (selectedTab == PickerTab.gifs) {
                  giphyController.search(value);
                }
              },
            ),
          ),
          Expanded(
            child: _buildBody(),
          ),
          const SizedBox(height: 5),
          _buildTabs(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (selectedTab) {
      case PickerTab.emoji:
        return EmojiPickerWidget(
          searchQuery: searchQuery,
          onEmojiSelected: (Emoji emoji) {
            messagesController.addEmojiToMessage(emoji.emoji);
          },
        );
      case PickerTab.gifs:
        return _buildGiphyBody();
      case PickerTab.stickers:
        return Center(
          child: Text(
            "Stickers coming soon!",
            style: TextStyle(
              color: Pallet.font2,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
    }
  }

  Widget _buildGiphyBody() {
    return Obx(() {
      if (giphyController.isLoading.value &&
          (giphyController.isSearching.value
              ? giphyController.searchResults.isEmpty
              : giphyController.trendingGifs.isEmpty)) {
        return const Center(child: CircularProgressIndicator());
      }

      final List<Gif> gifs = giphyController.isSearching.value
          ? giphyController.searchResults
          : giphyController.trendingGifs;

      if (gifs.isEmpty) {
        return Center(
          child: Text(
            giphyController.isSearching.value
                ? "No GIFs found."
                : "No trending GIFs.",
            style: TextStyle(color: Pallet.font2),
          ),
        );
      }

      return GridView.builder(
        padding: const EdgeInsets.all(5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: gifs.length,
        itemBuilder: (context, index) {
          final gif = gifs[index];
          return InkWell(
            onTap: () => messagesController.sendInlineGifMessage(gif),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                gif.previewUrl ?? gif.url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildTabs() {
    return Row(
      children: [
        _buildTabButton("emoji", PickerTab.emoji),
        _buildTabButton("gif", PickerTab.gifs),
        _buildTabButton("stickers", PickerTab.stickers),
      ],
    );
  }

  Widget _buildTabButton(String label, PickerTab tab) {
    bool isSelected = selectedTab == tab;
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedTab = tab;
            // Clear search or re-trigger search for the new tab?
            // For now, keep query and re-trigger if needed
            if (tab == PickerTab.gifs && searchQuery.isNotEmpty) {
              giphyController.search(searchQuery);
            }
          });
        },
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Pallet.font1 : Pallet.font2,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
