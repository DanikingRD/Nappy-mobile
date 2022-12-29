import 'package:flutter/material.dart';

class VisibilityTextField extends StatefulWidget {
  final Widget? prefixIcon;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  const VisibilityTextField({
    super.key,
    this.prefixIcon,
    this.hintText,
    this.hintTextStyle,
    this.onChanged,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  State<VisibilityTextField> createState() => _VisibilityTextFieldState();
}

class _VisibilityTextFieldState extends State<VisibilityTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Theme(
      // Note: Overriding IconButton#style didn't work on Flutter 3.3.10
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        obscureText: obscureText,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintTextStyle,
          suffixIcon: IconButton(
            onPressed: updateState,
            icon: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: theme.iconTheme.color,
            ),
          ),
          prefixIcon: widget.prefixIcon,
        ),
      ),
    );
  }

  void updateState() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
