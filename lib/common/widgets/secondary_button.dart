import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const SecondaryButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Note: I use align here to set the default width of the button
    // in case it is inside a ListView. Otherwise it will expand taking full width.
    return Align(
      child: TextButton(
        style: const ButtonStyle(
          overlayColor: MaterialStatePropertyAll(Colors.transparent),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: theme.textTheme.bodyText1,
        ),
      ),
    );
  }
}
