import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';

class ExternalAuthButton extends StatefulWidget {
  final VoidCallback onClick;
  final String logoPath;
  final String title;
  const ExternalAuthButton({
    super.key,
    required this.onClick,
    required this.logoPath,
    required this.title,
  });

  @override
  State<ExternalAuthButton> createState() => _ExternalAuthButtonState();
}

class _ExternalAuthButtonState extends State<ExternalAuthButton> {
  Color color = NappyColors.landing;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: TextButton.icon(
        onPressed: widget.onClick,
        onHover: (value) {
          setState(() => color = value ? NappyColors.primary : NappyColors.landing);
        },
        style: TextButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        icon: Image.asset(
          widget.logoPath,
          width: 35,
        ),
        label: Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
