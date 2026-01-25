import 'package:flutter/material.dart';
import '../config/palette.dart';

class MentionSuggestion {
  final String id;
  final String name;
  final String type; // 'flow' or 'doc'

  MentionSuggestion({
    required this.id,
    required this.name,
    required this.type,
  });
}

class MentionTextBox extends StatefulWidget {
  final TextEditingController controller;
  final Future<List<MentionSuggestion>> Function(String query) onSearch;
  final int maxLines;
  final String? hintText;
  final Function(String)? onEnter;
  final Function(String)? onType;
  final String? errorText;

  const MentionTextBox({
    super.key,
    required this.controller,
    required this.onSearch,
    this.maxLines = 1,
    this.hintText,
    this.onEnter,
    this.onType,
    this.errorText,
  });

  @override
  State<MentionTextBox> createState() => _MentionTextBoxState();
}

class _MentionTextBoxState extends State<MentionTextBox> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<MentionSuggestion> _suggestions = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _removeOverlay();
    super.dispose();
  }

  void _onTextChanged() {
    final text = widget.controller.text;
    final selection = widget.controller.selection;

    if (!selection.isValid || selection.baseOffset < 0) {
      _removeOverlay();
      return;
    }

    final String textBeforeCursor = text.substring(0, selection.baseOffset);
    final int hashIndex = textBeforeCursor.lastIndexOf('#');

    if (hashIndex != -1) {
      // check if there is a space before #, or it matches start of line
      bool validTrigger = false;
      if (hashIndex == 0) {
        validTrigger = true;
      } else if (textBeforeCursor[hashIndex - 1] == ' ' ||
          textBeforeCursor[hashIndex - 1] == '\n') {
        validTrigger = true;
      }

      if (validTrigger) {
        final query = textBeforeCursor.substring(hashIndex + 1);
        // Only trigger if query doesn't contain spaces (simple mention)
        if (!query.contains(' ')) {
          _fetchSuggestions(query);
          return;
        }
      }
    }

    _removeOverlay();
  }

  Future<void> _fetchSuggestions(String query) async {
    // If we are already showing suggestions, maybe show loading state?
    // For now just fetch and update.
    // Debouncing could be added here if needed.

    // setState(() => _isLoading = true);
    final results = await widget.onSearch(query);
    if (!mounted) return;

    setState(() {
      _suggestions = results;
      _isLoading = false;
    });

    if (_suggestions.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      // Rebuild if already showing to update list
      _overlayEntry!.markNeedsBuild();
      return;
    }

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: 250, // Fixed width for dropdown
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 40), // Offset below the text field
            child: Material(
              elevation: 4,
              color: Pallet.inside3,
              borderRadius: BorderRadius.circular(5),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    final item = _suggestions[index];
                    return InkWell(
                      onTap: () => _selectItem(item),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.type == 'flow'
                                  ? Icons.schema
                                  : Icons.description,
                              size: 14,
                              color: Pallet.font2,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  color: Pallet.font1,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void _selectItem(MentionSuggestion item) {
    final text = widget.controller.text;
    final selection = widget.controller.selection;
    final textBeforeCursor = text.substring(0, selection.baseOffset);
    final hashIndex = textBeforeCursor.lastIndexOf('#');

    if (hashIndex != -1) {
      final prefix = text.substring(0, hashIndex);
      final suffix = text.substring(selection.baseOffset);
      final newText = '$prefix#${item.name} $suffix'; // Insert name + space

      widget.controller.text = newText;
      widget.controller.selection = TextSelection.collapsed(
        offset: hashIndex + 1 + item.name.length + 1,
      );
    }
    _removeOverlay();
  }

  // Copied style from SmallTextBox
  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: widget.controller,
            onChanged: (val) {
              // We also need to trigger onType if provided
              widget.onType?.call(val);
              // The listener _onTextChanged logic runs via controller listener mainly for cursor checks
            },
            onSubmitted: widget.onEnter,
            maxLines: widget.maxLines,
            style: TextStyle(fontSize: 12, color: Pallet.font1),
            decoration: InputDecoration(
              isDense: true,
              hintText: widget.hintText,
              filled: true,
              fillColor: Pallet.inside1,
              hintStyle: TextStyle(color: Pallet.font3, fontSize: 12),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: widget.errorText != null
                    ? BorderSide(color: Colors.red)
                    : BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: widget.errorText != null
                    ? BorderSide(color: Colors.red)
                    : BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: widget.errorText != null
                    ? BorderSide(color: Colors.red)
                    : BorderSide(color: Pallet.divider),
              ),
            ),
          ),
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                widget.errorText!,
                style: TextStyle(color: Colors.red, fontSize: 10),
              ),
            ),
        ],
      ),
    );
  }
}
