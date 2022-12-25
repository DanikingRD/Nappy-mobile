import 'package:flutter/material.dart';
import 'package:nappy_mobile/constants/colors.dart';
import 'package:nappy_mobile/constants/ui.dart';

/// The PrimaryButton is used for <i> primary actions </i>.
/// In other words for executing tasks that are helpful for
/// the goals of the user. (e.g log in, register or create a profile.).
class PrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  const PrimaryButton({
    super.key,
    required this.child,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 45,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: NappyColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: kButtonBorderRadius,
          ),
          elevation: 0.0,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
