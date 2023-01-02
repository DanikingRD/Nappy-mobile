import 'package:flutter/material.dart';
import 'package:nappy_mobile/features/auth/views/auth_view.dart';
import 'package:nappy_mobile/features/auth/views/pages/account_recovery_page.dart';
import 'package:nappy_mobile/features/auth/views/pages/login_page.dart';
import 'package:nappy_mobile/features/auth/views/pages/signup_page.dart';
import 'package:nappy_mobile/features/dashboard/views/dashboard_view.dart';
import 'package:routemaster/routemaster.dart';

class Routes {
  const Routes._();

  static const String rootRoute = "/";
  static const String loginRoute = "/login";
  static const String signupRoute = "/signup";
  static const String recoveryRoute = "/recovery";

  // Private routes
  static const String cards = "/cards";
  static const String contacts = "/contacts";

  // Initial Routes
  static const String publicInitialRoute = loginRoute;
  static const String privateInitialRoute = rootRoute;

  /// Purpose: Let the user access the public routes of the app,
  /// i.e pages that are visible to everyone if they are logged out.
  static final publicRoutes = RouteMap(
    onUnknownRoute: (_) => const Redirect(loginRoute),
    routes: {
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

  /// Purpose: Do not allow anyone to access these routes without signing jn.
  static final privateRoutes = RouteMap(
    onUnknownRoute: (_) => const Redirect(privateInitialRoute),
    routes: {
      rootRoute: (route) {
        return const MaterialPage(child: DashboardView());
      },
      // cards: (route) {
      //   return const MaterialPage(child: DashboardView());
      // },
      // contacts: (route) {
      //   return const MaterialPage(child: DashboardView());
      // },
    },
  );
  static void navigate(BuildContext context, String route) {
    Routemaster.of(context).push(route);
  }
}
