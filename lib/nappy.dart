import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/constants/themes.dart';
import 'package:nappy_mobile/common/global_providers.dart';
import 'package:nappy_mobile/router.dart';
import 'package:nappy_mobile/services/auth_service.dart';
import 'package:routemaster/routemaster.dart';

class Nappy extends ConsumerWidget {
  const Nappy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authEvents = ref.watch(authStateChangesProvider);
    return authEvents.when(
      data: (optionalId) {
        return MaterialApp.router(
          routerDelegate: RoutemasterDelegate(
            routesBuilder: (context) {
              return optionalId.match(
                () => Routes.publicRoutes,
                (id) => Routes.publicRoutes,
              );
            },
          ),
          routeInformationParser: const RoutemasterParser(),
          theme: kLightTheme,
          debugShowCheckedModeBanner: false,
        );
      },
      error: (error, stack) => Center(child: Text(error.toString())),
      loading: () => const Center(
        child: CircularProgressIndicator(
          color: NappyColors.primary,
        ),
      ),
    );
  }
}

class ExtendedScrollBehaviour extends ScrollBehavior {
  const ExtendedScrollBehaviour();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}
