import 'package:flutter/material.dart';
import '../../../config/palette.dart';
import '../widgets/chat_picker.dart';

class EmojiButton extends StatefulWidget {
  const EmojiButton({super.key});

  @override
  State<EmojiButton> createState() => _EmojiButtonState();
}

class _EmojiButtonState extends State<EmojiButton> {
  final GlobalKey _actionKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  void _toggleDropdown() {
    if (_isOpen) {
      _closeDropdown();
    } else {
      _openDropdown();
    }
  }

  void _openDropdown() {
    final renderBox =
        _actionKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = _createOverlayEntry(offset, size);
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  OverlayEntry _createOverlayEntry(Offset offset, Size size) {
    const double pickerHeight = 350;
    const double pickerWidth = 400;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _closeDropdown,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: offset.dx - (pickerWidth / 2) + (size.width / 2),
            top: offset.dy - pickerHeight - 20,
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: pickerWidth,
                height: pickerHeight,
                child: const ChatPicker(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: _actionKey,
      onTap: _toggleDropdown,
      child: Icon(
        Icons.sentiment_satisfied_alt_outlined,
        color: _isOpen ? Pallet.font1 : Pallet.font3,
        size: 24,
      ),
    );
  }
}
