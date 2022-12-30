import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/constants/ui.dart';

typedef MaterialState<T> = MaterialStatePropertyAll<T>;

/// The PrimaryButton is used for <i> primary actions </i>.
/// In other words for executing tasks that are helpful for
/// the goals of the user. (e.g log in, register or create a profile.).
class PrimaryButton extends StatefulWidget {
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
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  Color color = NappyColors.primary;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: color,
        borderRadius: kButtonBorderRadius,
      ),
      child: SizedBox(
        width: 260,
        height: 45,
        child: TextButton(
          onHover: updateColor,
          onPressed: widget.onPressed,
          child: widget.loading
              ? const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 24,
                )
              : Text(
                  widget.text,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Colors.white,
                      ),
                ),
        ),
      ),
    );
  }

  void updateColor(bool value) {
    setState(() {
      color = value ? NappyColors.primaryHover : NappyColors.primary;
    });
  }
}
