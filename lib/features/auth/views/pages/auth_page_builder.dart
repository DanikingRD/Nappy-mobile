import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/constants/colors.dart';
import 'package:nappy_mobile/features/auth/controllers/auth_controller.dart';
import 'package:nappy_mobile/features/auth/state/auth_form.dart';
import 'package:nappy_mobile/util/responsive.dart';

class AuthPageBuilder extends ConsumerWidget {
  final List<Widget> Function(
    BuildContext context,
    AuthForm state,
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
  Widget build(BuildContext context, WidgetRef ref) {
    final double width = MediaQuery.of(context).size.width;
    final margin = Responsive.isSmallScreen(context) ? 40.0 : width * 0.1;
    final controller = ref.watch(formControllerProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: margin),
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(title, style: textTheme.headline1),
        const SizedBox(
          height: 10,
        ),
        Text(
          subtitle,
          style: textTheme.subtitle1!.copyWith(
            color: NappyColors.mutedText,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        ...builder(context, controller, theme),
      ],
    );
  }
}
