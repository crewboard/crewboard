import 'package:flutter/material.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../config/palette.dart';
import 'glass_morph.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'buttons.dart';
import 'text_box.dart';
import 'color_picker.dart';

class CreateItemOverlayButton extends StatefulWidget {
  const CreateItemOverlayButton({
    super.key,
    required this.onSave,
    this.showColor = false,
  });

  final Function(String, UuidValue?) onSave;
  final bool showColor;

  @override
  State<CreateItemOverlayButton> createState() =>
      _CreateItemOverlayButtonState();
}

class _CreateItemOverlayButtonState extends State<CreateItemOverlayButton> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey _actionKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  UuidValue? _selectedColorId;
  bool _isOpen = false;

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isOpen = false;
    });
  }

  void _showOverlay() {
    final renderBox =
        _actionKey.currentContext!.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return GestureDetector(
          onTap: _hideOverlay,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned(
                left: offset.dx,
                top: offset.dy + size.height + 5,
                child: GestureDetector(
                  onTap: () {}, // Prevent tap from closing overlay
                  child: Material(
                    color: Colors.transparent,
                    child: GlassMorph(
                      width: 220,
                      borderRadius: 10,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(color: Pallet.font1, fontSize: 12),
                          ),
                          const SizedBox(height: 10),
                          SmallTextBox(
                            controller: _controller,
                            hintText: "Enter name...",
                          ),
                          if (widget.showColor) ...[
                            const SizedBox(height: 10),
                            ColorPicker(
                              selectedColorId: _selectedColorId,
                              onColorSelected: (systemColor) {
                                setState(() {
                                  _selectedColorId = systemColor.id;
                                });
                                _overlayEntry?.markNeedsBuild();
                              },
                            ),
                          ],
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SmallButton(
                                label: "Cancel",
                                onPress: _hideOverlay,
                              ),
                              const SizedBox(width: 10),
                              SmallButton(
                                label: "Save",
                                color: Colors.blue.withValues(alpha: 0.2),
                                onPress: () {
                                  widget.onSave(
                                    _controller.text,
                                    _selectedColorId,
                                  );
                                  _controller.clear();
                                  _hideOverlay();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    if (_isOpen) {
      _hideOverlay();
    } else {
      _showOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AddButton(
      key: _actionKey,
      onPress: _toggle,
    );
  }
}

class CreateItemInlineButton extends StatefulWidget {
  const CreateItemInlineButton({
    super.key,
    required this.onSave,
    required this.label,
    this.showColor = false,
  });

  final Function(String, UuidValue?) onSave;
  final String label;
  final bool showColor;

  @override
  State<CreateItemInlineButton> createState() => _CreateItemInlineButtonState();
}

class _CreateItemInlineButtonState extends State<CreateItemInlineButton> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey _actionKey = GlobalKey();
  UuidValue? _selectedColorId;
  bool _isOpen = false;

  void _saveAndClose() {
    widget.onSave(
      _controller.text,
      _selectedColorId,
    );
    _controller.clear();
    setState(() {
      _isOpen = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isOpen) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Pallet.inside1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(color: Pallet.font1, fontSize: 12),
            ),
            const SizedBox(height: 10),
            SmallTextBox(
              controller: _controller,
              hintText: "Enter name...",
              onEnter: (value) => _saveAndClose(),
            ),
            SizedBox(height: 10),
            if (widget.showColor) ...[
              const SizedBox(height: 10),
              ColorPicker(
                selectedColorId: _selectedColorId,
                onColorSelected: (systemColor) {
                  setState(() {
                    _selectedColorId = systemColor.id;
                  });
                },
              ),
            ],
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmallButton(
                  label: "close",
                  onPress: () {
                    setState(() {
                      _isOpen = false;
                    });
                  },
                ),
                const SizedBox(width: 6),
                SmallButton(
                  label: "done",
                  onPress: _saveAndClose,
                ),
              ],
            ),
          ],
        ).animate().fade(duration: 200.ms),
      );
    }

    return Button(
      key: _actionKey,
      label: widget.label,
      onPress: () {
        setState(() {
          _isOpen = true;
        });
      },
    ).animate().fade(duration: 500.ms);
  }
}
