import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';

class TextBox extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onSuffixIconPressed;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final bool autofocus;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Function(String)? onType;
  final bool isPassword;
  final String? errorText;

  const TextBox({
    super.key,
    required this.controller,
    this.labelText = "",
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onSuffixIconPressed,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.autofocus = false,
    this.focusNode,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.borderColor,
    this.focusedBorderColor,
    this.borderRadius,
    this.contentPadding,
    this.onType,
    this.isPassword = false,
    this.errorText,
  });

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  bool _obscureText = false;
  late FocusNode _focusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
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
    final defaultBorderRadius = widget.borderRadius ?? 8.0;
    final defaultContentPadding =
        widget.contentPadding ??
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          autofocus: widget.autofocus,
          focusNode: _focusNode,
          onTap: widget.onTap,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
            if (widget.onType != null) {
              widget.onType!(value);
            }
          },
          onFieldSubmitted: widget.onSubmitted,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            filled: true,
            fillColor: Pallet.inside1,
            hintText: widget.labelText,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: Pallet.font1)
                : null,
            suffixIcon: _buildSuffixIcon(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              borderSide: BorderSide(
                color: _hasFocus
                    ? (widget.focusedBorderColor ?? Pallet.font1)
                    : (widget.borderColor ?? Colors.transparent),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              borderSide: BorderSide(
                color: _hasFocus
                    ? (widget.focusedBorderColor ?? Pallet.font1)
                    : (widget.borderColor ?? Colors.transparent),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              borderSide: BorderSide(
                color: widget.focusedBorderColor ?? Pallet.font1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              borderSide: const BorderSide(color: Colors.red),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
              ),
            ),
            contentPadding: defaultContentPadding,
            hintStyle: TextStyle(color: Pallet.font1),
            labelStyle: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 16.0),
            child: Text(
              widget.errorText!,
              style: const TextStyle(fontSize: 10, color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: Pallet.font1,
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else if (widget.suffixIcon != null) {
      return IconButton(
        icon: Icon(widget.suffixIcon, color: Pallet.font1),
        onPressed: widget.onSuffixIconPressed,
      );
    }
    return null;
  }
}

// Convenience widgets for common use cases
class EmailTextBox extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const EmailTextBox({
    super.key,
    required this.controller,
    this.labelText = 'Email',
    this.hintText,
    this.validator,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextBox(
      controller: controller,
      labelText: labelText,
      prefixIcon: Icons.email,
      keyboardType: TextInputType.emailAddress,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.next,
    );
  }
}

class PasswordTextBox extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const PasswordTextBox({
    super.key,
    required this.controller,
    this.labelText = 'Password',
    this.hintText,
    this.validator,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextBox(
      controller: controller,
      labelText: labelText,
      prefixIcon: Icons.lock,
      obscureText: true,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.done,
    );
  }
}

class UsernameTextBox extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool enabled;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const UsernameTextBox({
    super.key,
    required this.controller,
    this.labelText = 'Username',
    this.hintText,
    this.validator,
    this.enabled = true,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextBox(
      controller: controller,
      labelText: labelText,
      prefixIcon: Icons.person,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a username';
            }
            if (value.length < 3) {
              return 'Username must be at least 3 characters';
            }
            return null;
          },
      enabled: enabled,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      textInputAction: TextInputAction.next,
    );
  }
}

class SmallTextBox extends StatefulWidget {
  const SmallTextBox({
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
  State<SmallTextBox> createState() => _SmallTextBoxState();
}

class _SmallTextBoxState extends State<SmallTextBox> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Pallet.inside1,
            borderRadius: BorderRadius.circular(widget.radius ?? 5),
            border: Border.all(
              color: (hasError || _hasFocus)
                  ? Pallet.font1
                  : Colors.transparent,
            ),
          ),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                _hasFocus = hasFocus;
              });
            },
            child: TextField(
              obscureText: widget.isPassword,
              focusNode: _focusNode,
              onSubmitted: widget.onEnter,
              onChanged: (value) {
                hasError = false;
                if (widget.type == "time" &&
                    !RegExp(
                      r'^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$',
                    ).hasMatch(value) &&
                    value.isNotEmpty) {
                  hasError = true;
                }
                if (widget.type == "double" &&
                    !RegExp(r'^\d*\.?\d*$').hasMatch(value) &&
                    value.isNotEmpty) {
                  hasError = true;
                }
                if (widget.type == "int" &&
                    !RegExp(r'^[0-9]+$').hasMatch(value) &&
                    value.isNotEmpty) {
                  hasError = true;
                }
                setState(() {});

                if (widget.onType != null) {
                  widget.onType!(value);
                }
              },
              controller: widget.controller,
              style: TextStyle(fontSize: 12, color: Pallet.font1),
              maxLines: widget.maxLines ?? 1,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(fontSize: 12, color: Pallet.font3),
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        if (widget.errorText != null)
          Text(
            widget.errorText!,
            style: TextStyle(fontSize: 10, color: Colors.red),
          ),
      ],
    );
  }
}
