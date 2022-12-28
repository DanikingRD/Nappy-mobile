import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nappy_mobile/constants/colors.dart';
import 'package:nappy_mobile/constants/ui.dart';

/// The PrimaryButton is used for <i> primary actions </i>.
/// In other words for executing tasks that are helpful for
/// the goals of the user. (e.g log in, register or create a profile.).
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool loading;
  const PrimaryButton({
    super.key,
    this.loading = false,
    required this.text,
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
          foregroundColor: Colors.white, // changes splash color
          shape: RoundedRectangleBorder(
            borderRadius: kButtonBorderRadius,
          ),
          elevation: 0.0,
        ),
        onPressed: onPressed,
        child: loading
            ? const SpinKitThreeBounce(
                color: Colors.white,
                size: 24,
              )
            : Text(
                text,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      color: Colors.white,
                    ),
              ),
      ),
    );
  }
}
