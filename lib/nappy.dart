import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/constants/themes.dart';
import 'package:nappy_mobile/common/util/auth.dart';
import 'package:nappy_mobile/common/util/observers.dart';
import 'package:nappy_mobile/repositories/impl/auth_repository.dart';
import 'package:nappy_mobile/repositories/impl/user_repository.dart';
import 'package:nappy_mobile/router.dart';
import 'package:routemaster/routemaster.dart';

class Nappy extends ConsumerWidget {
  const Nappy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authEvents = ref.watch(authUpdateProvider);
    return authEvents.when(
      data: (optionalId) {
        return MaterialApp.router(
          routeInformationProvider: PlatformRouteInformationProvider(
            initialRouteInformation: const RouteInformation(location: Routes.publicInitialRoute),
          ),
          routerDelegate: RoutemasterDelegate(
            observers: [NappyRouteObserver()],
            routesBuilder: (context) {
              // This will rebuild when the user state changes
              return optionalId.match(
                () => Routes.publicRoutes,
                (id) {
                  return ref.watch(userProvider).match(
                    () {
                      setActiveUserWidget(ref, id);
                      return Routes.publicRoutes;
                    },
                    (user) {
                      if (user.id != id) {
                        // We got a different session
                        setActiveUserWidget(ref, id);
                      }
                      return Routes.privateRoutes;
                    },
                  );
                },
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
