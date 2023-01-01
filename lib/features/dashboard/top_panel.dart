import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';

class DashboardTopPanel extends StatelessWidget implements PreferredSizeWidget {
  final bool useDesktopLayout;
  const DashboardTopPanel({
    super.key,
    required this.useDesktopLayout,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 100.0,
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: useDesktopLayout ? const _DesktopTopPanel() : const _MobileTopPanel(),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(60.0);
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
  const _MobileTopPanel();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.menu,
        color: Colors.black,
      ),
    );
  }
}
