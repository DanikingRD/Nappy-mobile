import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nappy_mobile/constants/assets.dart';
import 'package:nappy_mobile/constants/breakpoints.dart';
import 'package:nappy_mobile/constants/colors.dart';
import 'package:nappy_mobile/constants/ui.dart';
import 'package:nappy_mobile/widgets/primary_button.dart';
import 'package:nappy_mobile/widgets/visibility_textfield.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevent TextField resizing widgets
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const Expanded(
                flex: 4,
                child: LoginBody(),
              ),
              const Spacer(),
              SvgPicture.asset(
                kWaveSvgPath,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginBody extends ConsumerWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return SizedBox(
      width: 400,
      child: ListView(
        
        padding: isMobile(context) ? kMobilePadding : EdgeInsets.zero,
        shrinkWrap: true,
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
          ),
          kTextFieldGap,
          VisibilityTextField(
            hintText: "Enter your password",
            prefixIcon: Icon(
              Icons.lock_outline,
              color: theme.iconTheme.color,
            ),
          ),
          kTextFieldGap,
          Align(
            alignment: Alignment.topRight,
            child: Text(
              "Forgot password?",
              style: textTheme.bodyText1,
            ),
          ),
          kDefaultMargin,
          PrimaryButton(
            onPressed: () {},
            child: Text("Sign in"),
          ),
          kDefaultMargin,
          Row(
            children: [
              Text(
                "Not a member yet?",
                style: textTheme.subtitle1,
              ),
              const Spacer(),
              Text(
                "Sign Up",
                style: textTheme.subtitle1!.copyWith(color: NappyColors.primary),
              ),
            ],
          )
        ],
      ),
    );
  }
}
