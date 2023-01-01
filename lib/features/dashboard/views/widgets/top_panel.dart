import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';

class DashboardTopPanel extends StatelessWidget implements PreferredSizeWidget {
  final bool useDesktopLayout;
  final GlobalKey<ScaffoldState> scaffoldKey;
  const DashboardTopPanel({
    super.key,
    required this.useDesktopLayout,
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: AppBar(
        backgroundColor: const Color(0xffF8F8F8),
        leadingWidth: 100.0,
        elevation: 0.0,
        leading: useDesktopLayout
            ? const _DesktopTopPanel()
            : _MobileTopPanel(
                scaffoldKey: scaffoldKey,
              ),
        title: Text(
          "Dashboard",
          style: textTheme.headline1!.copyWith(
            color: NappyColors.dark,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        actions: [
          if (useDesktopLayout) ...{
            Container(
              decoration: BoxDecoration(
                color: NappyColors.profileContainerColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 25,
                      decoration: BoxDecoration(
                        color: NappyColors.dark,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Your username",
                          style: textTheme.bodyText1!.copyWith(color: NappyColors.dark),
                        ),
                        Text(
                          "admin",
                          style: textTheme.bodyText1!.copyWith(color: NappyColors.dark),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: NappyColors.dark,
                      ),
                    )
                  ],
                ),
              ),
            ),
          }
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(100.0);
}

class _DesktopTopPanel extends StatelessWidget {
  const _DesktopTopPanel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              color: NappyColors.primary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: Text(
                "Nappy",
                style: theme.textTheme.headline1!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileTopPanel extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const _MobileTopPanel({
    required this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        scaffoldKey.currentState?.openDrawer();
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
    );
  }
}
