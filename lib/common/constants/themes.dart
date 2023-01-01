import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/constants/styles.dart';

final kLightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: NappyColors.primary,
  ),
  checkboxTheme: kPrimaryCheckboxTheme,
  inputDecorationTheme: kPrimaryInputDecorationTheme,
  scaffoldBackgroundColor: Colors.white,
  primaryIconTheme: kPrimaryIconTheme,
  iconTheme: kPrimaryIconTheme,
  // fontFamily: kPoppinsFont,
  textTheme: TextTheme(
    headline1: kHeadline1,
    subtitle1: kSubtitle1,
    bodyText1: kBodyText1,
    bodyText2: kBodyText2,
  ),
  textSelectionTheme: kTextSelectionTheme,
);
