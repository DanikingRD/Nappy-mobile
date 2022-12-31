import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/util/responsive.dart';

class AuthPageBuilder extends StatelessWidget {
  final List<Widget> Function(
    BuildContext context,
    ThemeData theme,
  ) builder;
  final String title;
  final String subtitle;
  const AuthPageBuilder({
    super.key,
    required this.builder,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final margin = Responsive.isSmallScreen(context) ? 40.0 : width * 0.1;
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Form(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: margin),
        children: [
          const SizedBox(
            height: 30,
          ),
          SelectableText(title, style: textTheme.headline1),
          const SizedBox(
            height: 10,
          ),
          SelectableText(
            subtitle,
            style: textTheme.subtitle1!.copyWith(
              color: NappyColors.mutedText,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ...builder(context, theme),
        ],
      ),
    );
  }
}
