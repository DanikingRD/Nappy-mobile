import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/constants/assets.dart';
import 'package:nappy_mobile/constants/ui.dart';
import 'package:nappy_mobile/features/auth/controllers/login_controller.dart';
import 'package:nappy_mobile/features/auth/views/widgets/external_auth_button.dart';
import 'package:nappy_mobile/features/auth/views/widgets/external_auth_divider.dart';

class AuthProvidersList extends StatelessWidget {
  const AuthProvidersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ExternalAuthDivider("Or"),
        kDefaultMargin,
        Consumer(
          builder: (context, ref, child) {
            return ExternalAuthButton(
              onClick: () {
                ref.read(loginControllerProvider.notifier).signInWithGoogle(context);
              },
              logoPath: kGoogleImgPath,
              title: "Continue With Google",
            );
          },
        ),
        kDefaultMargin,
      ],
    );
  }
}
