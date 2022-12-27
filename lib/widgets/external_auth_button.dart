import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nappy_mobile/constants/colors.dart';

class ExternalAuthButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onClick,
      style: TextButton.styleFrom(
        backgroundColor: NappyColors.landing,
        foregroundColor: Colors.white, // changes splash color
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        elevation: 0.0,
      ),
      icon: Image.asset(
        logoPath,
        width: 35,
      ),
      label: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
