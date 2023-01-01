import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/common/util/responsive.dart';
import 'package:nappy_mobile/features/dashboard/views/pages/dashboard_overview.dart';
import 'package:nappy_mobile/features/dashboard/views/widgets/top_panel.dart';
import 'package:nappy_mobile/features/dashboard/views/widgets/side_panel.dart';

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  static final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useDesktopLayout = Responsive.isTabletOrGreater(context, offset: 250);
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      key: scaffoldKey,
      appBar: DashboardTopPanel(
        useDesktopLayout: useDesktopLayout,
        scaffoldKey: scaffoldKey,
      ),
      body: Row(
        children: const [
          Expanded(
            child: DashboardSidePanel(),
          ),
          Expanded(
            flex: 5,
            child: DashboardOverview(),
          )
        ],
      ),
    );
  }
}
