import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';

class ExternalAuthDivider extends StatelessWidget {
  final String title;
  const ExternalAuthDivider(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const div = Expanded(
      child: Divider(
        thickness: 0.5,
        color: NappyColors.divider,
      ),
    );
    return Row(
      children: [
        div,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: theme.textTheme.bodyText1,
          ),
        ),
        div,
      ],
    );
  }
}
