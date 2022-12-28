import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nappy_mobile/constants/assets.dart';
import 'package:nappy_mobile/constants/colors.dart';
import 'package:nappy_mobile/constants/ui.dart';
import 'package:nappy_mobile/features/auth/controllers/auth_controller.dart';
import 'package:nappy_mobile/features/auth/controllers/auth_page_controller.dart';
import 'package:nappy_mobile/features/auth/views/pages/auth_page_builder.dart';
import 'package:nappy_mobile/widgets/external_auth_button.dart';
import 'package:nappy_mobile/widgets/external_auth_divider.dart';
import 'package:nappy_mobile/widgets/primary_button.dart';
import 'package:nappy_mobile/widgets/visibility_textfield.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthPageBuilder(
      title: "Sign in",
      subtitle: "Please fill in the credentials",
      builder: (context, state, theme) {
        final textTheme = theme.textTheme;
        return [
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.email_outlined,
                color: theme.iconTheme.color,
              ),
              hintText: "Enter your email address",
            ),
            onChanged: (String? e) {
              ref.read(formControllerProvider.notifier).onEmailUpdate(e);
            },
            keyboardType: TextInputType.emailAddress,
          ),
          kTextFieldGap,
          VisibilityTextField(
            hintText: "Enter your password",
            prefixIcon: Icon(
              Icons.lock_outline,
              color: theme.iconTheme.color,
            ),
            onChanged: (String? pw) {
              ref.read(formControllerProvider.notifier).onPasswordUpdate(pw);
            },
          ),
          kTextFieldGap,
          Align(
            alignment: Alignment.topRight,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot password?",
                  style: textTheme.bodyText1,
                ),
              ),
            ),
          ),
          kDefaultMargin,
          PrimaryButton(
            onPressed: () async {
              await ref.read(formControllerProvider.notifier).signIn(context);
            },
            text: "Sign in",
            loading: state.loading,
          ),
          kDefaultMargin,
          const ExternalAuthDivider("Or"),
          kDefaultMargin,
          ExternalAuthButton(
            onClick: () async {
              await ref.read(formControllerProvider.notifier).signInWithGoogle(context);
            },
            logoPath: kGoogleImgPath,
            title: "Continue With Google",
          ),
          kDefaultMargin,
          Row(
            children: [
              Text(
                "Not a member yet?",
                style: textTheme.subtitle1,
              ),
              const Spacer(),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    ref.read(authPageControllerProvider.notifier).showSignUp();
                  },
                  child: Text(
                    "Sign Up",
                    style: textTheme.subtitle1!.copyWith(color: NappyColors.primary),
                  ),
                ),
              ),
            ],
          )
        ];
      },
    );
  }
}
