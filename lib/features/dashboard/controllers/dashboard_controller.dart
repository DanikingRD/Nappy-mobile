import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/features/dashboard/views/pages/dashboard_cards_page.dart';
import 'package:nappy_mobile/features/dashboard/views/pages/dashboard_contacts_page.dart';
import 'package:nappy_mobile/features/dashboard/views/pages/dashboard_overview.dart';

final dashboardController = StateProvider<int>((ref) => 0);

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
