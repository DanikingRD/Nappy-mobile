import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/util/responsive.dart';
import 'package:nappy_mobile/features/auth/controllers/auth_page_controller.dart';
import 'package:nappy_mobile/features/auth/states/auth_page.dart';

class AuthView extends ConsumerWidget {
  static const Duration fadeDuration = Duration(milliseconds: 300);
  const AuthView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authPageControllerProvider);
    return Scaffold(
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
                child: state.activePage.toWidget(),
              )
            ],
          ),
        ),
      ),
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
