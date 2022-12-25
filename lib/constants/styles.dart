import 'package:flutter/material.dart';
import 'package:nappy_mobile/constants/colors.dart';

const TextStyle kHeadline1 = TextStyle(
  fontSize: 24,
  color: NappyColors.primary,
  fontWeight: FontWeight.w500,
);

const TextStyle kSubtitle1 = TextStyle(
  fontSize: 16,
  color: NappyColors.primaryFillText,
);

const TextStyle kBodyText1 = TextStyle(
  fontSize: 16,
  color: NappyColors.primary,
  fontWeight: FontWeight.normal,
);

InputDecorationTheme kPrimaryInputDecorationTheme = const InputDecorationTheme(
  fillColor: NappyColors.primaryFill,
  filled: true,
  border: InputBorder.none,
  hintStyle: kSubtitle1,
);

const IconThemeData kPrimaryIconTheme = IconThemeData(
  color: NappyColors.primaryFillText,
);

const TextSelectionThemeData kTextSelectionTheme = TextSelectionThemeData(
  cursorColor: NappyColors.primary,
  selectionHandleColor: NappyColors.selectionHandle,
  selectionColor: NappyColors.selectionColor,
);
