import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/features/auth/controllers/auth_page_controller.dart';
import 'package:nappy_mobile/features/auth/views/pages/auth_page_builder.dart';
import 'package:nappy_mobile/widgets/primary_button.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AuthPageBuilder(
      title: "Sign up",
      subtitle: "Create an account to get started!",
      builder: (context, state, theme) {
        return [
          const SizedBox(
            height: 30,
          ),
          PrimaryButton(
            text: "Show login",
            onPressed: () {
              ref.read(authPageControllerProvider.notifier).showLogin();
            },
          )
        ];
      },
    );
  }
}
