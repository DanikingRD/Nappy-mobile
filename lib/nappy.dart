import 'package:flutter/material.dart';
import 'package:nappy_mobile/constants/assets.dart';
import 'package:nappy_mobile/constants/colors.dart';
import 'package:nappy_mobile/constants/styles.dart';
import 'package:nappy_mobile/router.dart';
import 'package:routemaster/routemaster.dart';

class Nappy extends StatelessWidget {
  const Nappy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: const RoutemasterParser(),
      routerDelegate: RoutemasterDelegate(
        routesBuilder: (context) => publicRoutes,
      ),
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: NappyColors.primary,
        ),
        inputDecorationTheme: kPrimaryInputDecorationTheme,
        scaffoldBackgroundColor: Colors.white,
        primaryIconTheme: kPrimaryIconTheme,
        iconTheme: kPrimaryIconTheme,
        fontFamily: kPoppinsFont,
        textTheme: TextTheme(
          headline1: kHeadline1,
          subtitle1: kSubtitle1,
          bodyText1: kBodyText1,
        ),
        textSelectionTheme: kTextSelectionTheme,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ExtendedScrollBehaviour extends ScrollBehavior {
  const ExtendedScrollBehaviour();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
  }
}
