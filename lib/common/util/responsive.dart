import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/breakpoints.dart';

// ignore: avoid_classes_with_only_static_members
class Responsive {
  static bool isTabletOrGreater(BuildContext ctx, {double offset = 0}) {
    final MediaQueryData query = MediaQuery.of(ctx);
    return query.size.width >= kTabletMinWidth + offset;
  }

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < kTabletMinWidth;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > kDesktopMinWidth;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= kTabletMinWidth &&
        MediaQuery.of(context).size.width <= kDesktopMinWidth;
  }
}
