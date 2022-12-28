import 'package:flutter/cupertino.dart';
import 'package:nappy_mobile/constants/assets.dart';
import 'package:nappy_mobile/constants/ui.dart';
import 'package:nappy_mobile/features/auth/controllers/login_controller.dart';
import 'package:nappy_mobile/features/auth/views/widgets/external_auth_button.dart';
import 'package:nappy_mobile/features/auth/views/widgets/external_auth_divider.dart';

class AuthProvidersList extends StatelessWidget {
  final LoginController controller;
  const AuthProvidersList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ExternalAuthDivider("Or"),
        kDefaultMargin,
        ExternalAuthButton(
          onClick: () async {
            await controller.signInWithGoogle(context);
          },
          logoPath: kGoogleImgPath,
          title: "Continue With Google",
        ),
        kDefaultMargin,
      ],
    );
  }
}
