import 'package:flutter/material.dart';
import 'package:nappy_mobile/constants/colors.dart';
import 'package:nappy_mobile/constants/ui.dart';

/// The PrimaryButton is used for <i> primary actions </i>.
/// In other words for executing tasks that are helpful for
/// the goals of the user. (e.g log in, register or create a profile.).
class PrimaryButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final VoidCallback onPressed;
  const PrimaryButton({
    super.key,
    this.child,
    this.text,
    required this.onPressed,
  }) : assert(child == null || text == null, "You can't use both child and text");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 45,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: NappyColors.primary,
          foregroundColor: Colors.white, // changes splash color
          shape: RoundedRectangleBorder(
            borderRadius: kButtonBorderRadius,
          ),
          elevation: 0.0,
        ),
        onPressed: onPressed,
        child: child ??
            Text(
              text!,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Colors.white,
                  ),
            ),
      ),
    );
  }
}
