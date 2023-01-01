import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/util/responsive.dart';
import 'package:nappy_mobile/features/dashboard/views/widgets/destinations.dart';

class DashboardSidePanel extends StatelessWidget {
  const DashboardSidePanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // All this boilerplate makes the navigation rail scrollable.
      // refer to: https://github.com/flutter/flutter/issues/89167
      // TODO: find a less complicated approach to make it scrollable
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: NavigationRail(
                  backgroundColor: const Color(0xffF8F8F8),
                  useIndicator: true,
                  extended: Responsive.isTabletOrGreater(context),
                  selectedLabelTextStyle: textTheme.bodyText1!.copyWith(color: NappyColors.primary),
                  indicatorColor: NappyColors.primary,
                  selectedIconTheme: const IconThemeData(
                    color: Colors.white,
                  ),
                  destinations: getDashboardDestinations(textTheme),
                  selectedIndex: 0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
