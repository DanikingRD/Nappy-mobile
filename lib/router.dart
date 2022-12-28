import 'package:flutter/material.dart';
import 'package:nappy_mobile/features/auth/views/login_view.dart';
import 'package:nappy_mobile/features/home/views/home_view.dart';
import 'package:routemaster/routemaster.dart';

final publicRoutes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: LoginView()),
  },
);

final appRoutes = RouteMap(
  routes: {
    '/app/cards': (_) => const MaterialPage(child: HomeView()),
  },
);
