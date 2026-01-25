import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../../controllers/emoji_controller.dart';
import '../../../config/palette.dart';

class EmojiPickerWidget extends StatefulWidget {
  final Function(Emoji) onEmojiSelected;
  final String searchQuery;

  const EmojiPickerWidget({
    super.key,
    required this.onEmojiSelected,
    this.searchQuery = "",
  });

  @override
  State<EmojiPickerWidget> createState() => _EmojiPickerWidgetState();
}

class _EmojiPickerWidgetState extends State<EmojiPickerWidget> {
  final EmojiController emojiController = Get.find<EmojiController>();
  List<Emoji> searchResults = [];
  List<String> categories = [];
  final Map<String, List<Emoji>> categoryEmojis = {};
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final groups = await emojiController.getGroups();
    if (mounted) {
      setState(() {
        categories = groups;
        _isInit = true;
      });
      _filterEmojis(widget.searchQuery);
    }
  }

  @override
  void didUpdateWidget(EmojiPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _filterEmojis(widget.searchQuery);
    }
  }

  void _filterEmojis(String query) async {
    if (query.isNotEmpty) {
      final results = await emojiController.searchEmojis(query);
      if (mounted) {
        setState(() {
          searchResults = results;
        });
      }
    }
  }

  Future<List<Emoji>> _getCategoryEmojis(String category) async {
    if (categoryEmojis.containsKey(category)) {
      return categoryEmojis[category]!;
    }
    final emojis = await emojiController.getEmojisByGroup(category);
    categoryEmojis[category] = emojis;
    return emojis;
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'smileys & emotion':
        return Icons.emoji_emotions_outlined;
      case 'people & body':
        return Icons.people_outline;
      case 'animals & nature':
        return Icons.pets_outlined;
      case 'food & drink':
        return Icons.restaurant_outlined;
      case 'travel & places':
        return Icons.airplanemode_active_outlined;
      case 'activities':
        return Icons.sports_soccer_outlined;
      case 'objects':
        return Icons.lightbulb_outline;
      case 'symbols':
        return Icons.auto_awesome;
      case 'flags':
        return Icons.flag_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit) {
      return const Center(child: CircularProgressIndicator());
    }

    if (widget.searchQuery.isNotEmpty) {
      return _buildEmojiGrid(searchResults);
    }

    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: categories.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return FutureBuilder<List<Emoji>>(
                future: _getCategoryEmojis(categories[index]),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return _buildEmojiGrid(snapshot.data!);
                },
              );
            },
          ),
        ),
        _buildCategoryBar(),
      ],
    );
  }

  Widget _buildEmojiGrid(List<Emoji> emojis) {
    return GridView.builder(
      padding: const EdgeInsets.all(5),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 46,
        childAspectRatio: 1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemCount: emojis.length,
      itemBuilder: (context, index) {
        final emoji = emojis[index];
        return InkWell(
          onTap: () => widget.onEmojiSelected(emoji),
          child: Center(
            child: Text(
              emoji.emoji,
              style: const TextStyle(fontSize: 25),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = _currentPage == index;
          return IconButton(
            icon: Icon(
              _getCategoryIcon(categories[index]),
              color: isSelected ? Pallet.font1 : Pallet.font2,
              size: 20,
            ),
            onPressed: () {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
          );
        },
      ),
    );
  }
}
