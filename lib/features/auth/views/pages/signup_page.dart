import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/constants/ui.dart';
import 'package:nappy_mobile/features/auth/controllers/auth_page_controller.dart';
import 'package:nappy_mobile/features/auth/controllers/login_controller.dart';
import 'package:nappy_mobile/features/auth/controllers/signup_controller.dart';
import 'package:nappy_mobile/features/auth/views/auth_view.dart';
import 'package:nappy_mobile/features/auth/views/pages/auth_page_builder.dart';
import 'package:nappy_mobile/features/auth/views/widgets/auth_providers_list.dart';
import 'package:nappy_mobile/common/widgets/primary_button.dart';
import 'package:nappy_mobile/common/widgets/visibility_textfield.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(signUpControllerProvider.select((form) => form.loading));
    final hasAgreedTerms = ref.watch(signUpControllerProvider.select((form) => form.agreeTerms));
    return AuthPageBuilder(
      title: "Sign up",
      subtitle: "Create an account to get started!",
      builder: (context, theme) {
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
              ref.read(signUpControllerProvider.notifier).onEmailUpdate(e);
            },
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          kTextFieldGap,
          VisibilityTextField(
            hintText: "Enter your password",
            prefixIcon: Icon(
              Icons.lock_outline,
              color: theme.iconTheme.color,
            ),
            onChanged: (String? pw) {
              ref.read(signUpControllerProvider.notifier).onPasswordUpdate(pw);
            },
            textInputAction: TextInputAction.next,
          ),
          kTextFieldGap,
          VisibilityTextField(
            hintText: "Verify password",
            prefixIcon: Icon(
              Icons.lock_outline,
              color: theme.iconTheme.color,
            ),
            onChanged: (String? pw) {
              ref.read(signUpControllerProvider.notifier).onVerifyPasswordUpdate(pw);
            },
            textInputAction: TextInputAction.send,
            onFieldSubmitted: (value) {
              ref.read(signUpControllerProvider.notifier).register(context);
            },
          ),
          kTextFieldGap,
          Row(
            children: [
              Checkbox(
                value: hasAgreedTerms,
                onChanged: (val) {
                  ref.read(signUpControllerProvider.notifier).setAgreeTerms(val);
                },
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "I agree to the ",
                        style: textTheme.bodyText1!.copyWith(color: NappyColors.mutedText),
                      ),
                      TextSpan(text: "Privacy Policy", style: textTheme.bodyText1),
                      TextSpan(
                        text: " and ",
                        style: textTheme.bodyText1!.copyWith(
                          color: NappyColors.mutedText,
                        ),
                      ),
                      TextSpan(text: "Terms of Service", style: textTheme.bodyText1)
                    ],
                  ),
                ),
              ),
            ],
          ),
          kTextFieldGap,
          PrimaryButton(
            text: "Create account",
            onPressed: () {
              ref.read(signUpControllerProvider.notifier).register(context);
            },
            loading: isLoading,
          ),
          kDefaultMargin,
          const AuthProvidersList(),
          Row(
            children: [
              const Spacer(),
              Text(
                "Already have an account? ",
                style: textTheme.subtitle1,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    ref.read(authPageControllerProvider.notifier).showLogin();
                  },
                  child: Text(
                    "Log in",
                    style: textTheme.subtitle1!.copyWith(color: NappyColors.primary),
                  ),
                ),
              ),
              const Spacer(),
            ],
          )
        ];
      },
    ).animate().fade(duration: AuthView.fadeDuration);
  }
}
