import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:routemaster/routemaster.dart';

class NappyRouteObserver extends RoutemasterObserver {
  static final NappyLogger _logger = NappyLogger.getLogger((NappyRouteObserver).toString());
  @override
  void didPop(Route route, Route? previousRoute) {
    _logger.d("Popped route: $route");
  }

  // Routemaster-specific observer method
  @override
  void didChangeRoute(RouteData routeData, Page page) {
    _logger.d("Navigating to route [${routeData.fullPath}]");
  }
}
