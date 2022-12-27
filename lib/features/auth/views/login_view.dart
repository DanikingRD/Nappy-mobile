import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/auth_repository.dart';
import 'package:nappy_mobile/constants/assets.dart';
import 'package:nappy_mobile/constants/colors.dart';
import 'package:nappy_mobile/constants/ui.dart';
import 'package:nappy_mobile/features/auth/controllers/login_controller.dart';
import 'package:nappy_mobile/util/responsive.dart';
import 'package:nappy_mobile/widgets/dialog_box.dart';
import 'package:nappy_mobile/widgets/external_auth_button.dart';
import 'package:nappy_mobile/widgets/external_auth_divider.dart';
import 'package:nappy_mobile/widgets/primary_button.dart';
import 'package:nappy_mobile/widgets/visibility_textfield.dart';

class LoginView extends ConsumerWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent TextField resizing widgets
      body: SafeArea(
        child: Center(
          child: Row(
            children: [
              if (Responsive.isTabletOrGreater(context, offset: 200)) ...{
                const Expanded(
                  child: _SidePanel(),
                )
              },
              Expanded(
                flex: Responsive.isMediumScreen(context) ? 2 : 1,
                child: const _MobileLayout(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileLayout extends ConsumerWidget {
  const _MobileLayout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final double width = MediaQuery.of(context).size.width;
    final margin = Responsive.isSmallScreen(context) ? 40.0 : width * 0.1;
    final controller = ref.watch(loginControllerProvider);
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: margin),
      children: [
        const SizedBox(
          height: 30,
        ),
        Text("Sign in", style: textTheme.headline1),
        const SizedBox(
          height: 10,
        ),
        Text(
          "Please fill in the credentials",
          style: textTheme.subtitle1!.copyWith(
            color: NappyColors.mutedText,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.email_outlined,
              color: theme.iconTheme.color,
            ),
            hintText: "Enter your email address",
          ),
          onChanged: (String? e) {
            ref.read(loginControllerProvider.notifier).onEmailUpdate(e);
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
            ref.read(loginControllerProvider.notifier).onPasswordUpdate(pw);
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
            await ref.read(loginControllerProvider.notifier).register(context);
          },
          text: "Sign in",
        ),
        kDefaultMargin,
        const ExternalAuthDivider("Or"),
        kDefaultMargin,
        ExternalAuthButton(
          onClick: () async {},
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
                onTap: () {},
                child: Text(
                  "Sign Up",
                  style: textTheme.subtitle1!.copyWith(color: NappyColors.primary),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SidePanel extends StatelessWidget {
  const _SidePanel();

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      color: NappyColors.landing,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SelectableText(
            "Welcome to Nappy",
            style: Theme.of(context)
                .textTheme
                .headline1!
                .copyWith(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
