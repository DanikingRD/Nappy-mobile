import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/common/constants/ui.dart';
import 'package:nappy_mobile/common/widgets/primary_button.dart';
import 'package:nappy_mobile/common/widgets/secondary_button.dart';
import 'package:nappy_mobile/features/auth/controllers/login_controller.dart';
import 'package:nappy_mobile/features/auth/controllers/recovery_controller.dart';
import 'package:nappy_mobile/features/auth/views/auth_view.dart';
import 'package:nappy_mobile/features/auth/views/pages/auth_page_builder.dart';
import 'package:nappy_mobile/router.dart';

class AccountRecoveryPage extends ConsumerStatefulWidget {
  const AccountRecoveryPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthRecoveryPageState();
}

class _AuthRecoveryPageState extends ConsumerState<AccountRecoveryPage> {
  late final TextEditingController _recoveryEmail;
  @override
  void initState() {
    super.initState();
    final String? text = ref.read(loginControllerProvider).email;
    // Set initial text
    _recoveryEmail = TextEditingController(
      text: text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _recoveryEmail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(recoveryControllerProvider);
    return AuthPageBuilder(
      title: "Reset Password",
      subtitle: "Enter your email to get password recovery instructions",
      builder: (context, theme) {
        return [
          TextFormField(
            controller: _recoveryEmail,
            decoration: const InputDecoration(hintText: "Enter your email address"),
          ),
          kDefaultMargin,
          PrimaryButton(
            text: "Send Link",
            loading: isLoading,
            onPressed: () {
              ref.read(recoveryControllerProvider.notifier).submit(
                    context,
                    _recoveryEmail.text,
                  );
            },
          ),
          kDefaultMargin,
          SecondaryButton(
            title: "Return to Login Page",
            onPressed: () {
              Routes.navigate(context, Routes.loginRoute);
            },
          )
        ];
      },
    ).animate().fade(duration: AuthView.fadeDuration);
  }
}
