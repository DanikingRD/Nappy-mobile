import 'package:flutter/material.dart';
import 'package:nappy_mobile/features/auth/views/auth_view.dart';
import 'package:nappy_mobile/features/auth/views/pages/account_recovery_page.dart';
import 'package:nappy_mobile/features/auth/views/pages/login_page.dart';
import 'package:nappy_mobile/features/auth/views/pages/signup_page.dart';
import 'package:nappy_mobile/features/home/views/home_view.dart';
import 'package:routemaster/routemaster.dart';

class Routes {
  const Routes._();
  static const String rootRoute = "/";
  static const String loginRoute = "/login";
  static const String signupRoute = "/signup";
  static const String recoveryRoute = "/recovery";
  static final publicRoutes = RouteMap(
    routes: {
      rootRoute: (route) {
        return const MaterialPage(child: AuthView(page: LoginPage()));
      },
      loginRoute: (route) {
        return const MaterialPage(child: AuthView(page: LoginPage()));
      },
      signupRoute: (route) {
        return const MaterialPage(child: AuthView(page: SignupPage()));
      },
      recoveryRoute: (route) {
        return const MaterialPage(child: AuthView(page: AccountRecoveryPage()));
      }
    },
  );

  static final privateRoutes = RouteMap(
    routes: {
      rootRoute: (route) {
        return const MaterialPage(child: HomeView());
      },
    },
  );
  static void navigate(BuildContext context, String route) {
    Routemaster.of(context).replace(route);
  }
}
