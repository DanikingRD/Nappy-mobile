import 'package:flutter/material.dart';
import 'package:nappy_mobile/features/auth/views/auth_view.dart';
import 'package:nappy_mobile/features/auth/views/pages/login_page.dart';
import 'package:nappy_mobile/features/home/views/home_view.dart';
import 'package:nappy_mobile/nappy.dart';
import 'package:routemaster/routemaster.dart';

final publicRoutes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: ExtendedScrollWidget(AuthView())),
  },
);

final appRoutes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: ExtendedScrollWidget(HomeView())),
  },
);

class ExtendedScrollWidget extends StatelessWidget {
  final Widget child;
  const ExtendedScrollWidget(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ExtendedScrollBehaviour(),
      child: child,
    );
  }
}
