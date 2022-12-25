import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/constants/assets.dart';
import 'package:nappy_mobile/constants/styles.dart';
import 'package:nappy_mobile/features/auth/views/login_view.dart';

void main(List<String> args) {
  runApp(const ProviderScope(child: Nappy()));
}

class Nappy extends StatelessWidget {
  const Nappy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginView(),
      theme: ThemeData(
        inputDecorationTheme: kPrimaryInputDecorationTheme,
        scaffoldBackgroundColor: Colors.white,
        primaryIconTheme: kPrimaryIconTheme,
        iconTheme: kPrimaryIconTheme,
        fontFamily: kPoppinsFont,
        textTheme: const TextTheme(
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
