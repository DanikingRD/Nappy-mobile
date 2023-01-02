import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/features/dashboard/views/pages/dashboard_cards_page.dart';
import 'package:nappy_mobile/features/dashboard/views/pages/dashboard_contacts_page.dart';
import 'package:nappy_mobile/features/dashboard/views/pages/dashboard_overview.dart';
import 'package:nappy_mobile/router.dart';

final dashboardController = StateProvider.autoDispose<int>((ref) => 0, name: "DashboardController");

Widget mapIndexToPage(int i) {
  switch (i) {
    case 0:
      return const DashboardOverview();
    case 1:
      return const DashboardCardsPage();
    default:
      return const DashboardContactsPage();
  }
}

String mapIndexToRoute(int i) {
  switch (i) {
    case 0:
      return Routes.privateInitialRoute;
    case 1:
      return Routes.cards;
    case 2:
      return Routes.contacts;
    default:
      return Routes.contacts;
  }
}
