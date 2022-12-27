import 'package:flutter/material.dart';
import 'package:nappy_mobile/features/auth/views/login_view.dart';
import 'package:routemaster/routemaster.dart';

final publicRoutes = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(child: LoginView()),
  },
);
