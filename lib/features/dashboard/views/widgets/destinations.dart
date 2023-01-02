import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';

List<NavigationRailDestination> getDashboardDestinations(TextTheme textTheme) {
  return [
    NavigationRailDestination(
      icon: const Icon(Icons.dashboard),
      label: Text(
        "Dashboard",
        style: textTheme.bodyText1,
      ),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.credit_card),
      label: Text(
        "Personal Cards",
        style: textTheme.bodyText1!.copyWith(
          color: NappyColors.dark,
        ),
      ),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.person),
      label: Text(
        "Contacts",
        style: textTheme.bodyText1!.copyWith(
          color: NappyColors.dark,
        ),
      ),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.settings),
      label: Text(
        "Settings",
        style: textTheme.bodyText1!.copyWith(
          color: NappyColors.dark,
        ),
      ),
    ),
    NavigationRailDestination(
      icon: const Icon(Icons.exit_to_app),
      label: Text(
        "Logout",
        style: textTheme.bodyText1!.copyWith(
          color: NappyColors.dark,
        ),
      ),
    ),
  ];
}
