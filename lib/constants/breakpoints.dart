import 'package:flutter/cupertino.dart';

const double kDefaultViewWidth = 400.0;
const double kTabletMinWidth = 600.0;

bool isTabletOrGreater(BuildContext ctx) {
  final MediaQueryData query = MediaQuery.of(ctx);
  return query.size.width >= kTabletMinWidth;
}

bool isMobile(BuildContext context) {
  return !isTabletOrGreater(context);
}
