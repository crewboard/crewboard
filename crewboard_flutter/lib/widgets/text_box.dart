import 'package:flutter/material.dart';
import '../config/palette.dart';

// Minimal TextBox
class SmallTextBox extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onType;
  final int maxLines;
  final String? hintText;
  final Function(String)? onEnter;
  final bool isPassword;
  final String? errorText;

  const SmallTextBox({
    super.key,
    required this.controller,
    this.onType,
    this.maxLines = 1,
    this.hintText,
    this.onEnter,
    this.isPassword = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          onChanged: onType,
          onSubmitted: onEnter,
          maxLines: isPassword ? 1 : maxLines,
          obscureText: isPassword,
          style: TextStyle(fontSize: 12, color: Pallet.font1),
          decoration: InputDecoration(
            isDense: true,
            hintText: hintText,
            filled: true,
            fillColor: Pallet.inside1,
            hintStyle: TextStyle(color: Pallet.font3, fontSize: 12),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: errorText != null
                  ? BorderSide(color: Colors.red)
                  : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: errorText != null
                  ? BorderSide(color: Colors.red)
                  : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: errorText != null
                  ? BorderSide(color: Colors.red)
                  : BorderSide(color: Pallet.font1),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              errorText!,
              style: TextStyle(color: Colors.red, fontSize: 10),
            ),
          ),
      ],
    );
  }
}

class AppTextBox extends StatefulWidget {
  const AppTextBox({
    super.key,
    this.controller,
    this.maxLines,
    this.onType,
    this.onEnter,
    this.hintText,
    this.focus,
    this.radius,
    this.errorText,
    this.type,
    this.isPassword = false,
  });
  final TextEditingController? controller;
  final int? maxLines;
  final Function(String)? onType;
  final Function(String)? onEnter;
  final String? hintText;
  final FocusNode? focus;
  final double? radius;
  final bool isPassword;
  final String? errorText;
  final String? type;

  @override
  State<AppTextBox> createState() => _AppTextBoxState();
}

class _AppTextBoxState extends State<AppTextBox> {
  bool hasError = false;
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focus ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    if (widget.errorText != null) {
      hasError = true;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focus == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Pallet.inside1,
        borderRadius: BorderRadius.circular(widget.radius ?? 5),
        border: Border.all(
          color: hasError
              ? Colors.red
              : _hasFocus
              ? Pallet.font1
              : Colors.transparent,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        maxLines: widget.isPassword ? 1 : (widget.maxLines ?? 1),
        obscureText: widget.isPassword,
        focusNode: _focusNode,
        style: TextStyle(color: Pallet.font1, fontSize: 13),
        onChanged: widget.onType,
        onSubmitted: widget.onEnter,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Pallet.font3, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
