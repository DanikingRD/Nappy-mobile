import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nappy_mobile/common/constants/colors.dart';

TextStyle kHeadline1 = GoogleFonts.raleway().copyWith(
  fontSize: 24,
  color: NappyColors.primary,
  fontWeight: FontWeight.w500,
);
//TextStyle kHeadline1 = TextStyle();

TextStyle kSubtitle1 = GoogleFonts.raleway().copyWith(
  fontSize: 16,
  color: NappyColors.primaryFillText,
);
TextStyle kBodyText1 = GoogleFonts.raleway().copyWith(
  fontSize: 16,
  color: NappyColors.primary,
  fontWeight: FontWeight.normal,
);

InputDecorationTheme kPrimaryInputDecorationTheme = InputDecorationTheme(
  fillColor: NappyColors.primaryFill,
  filled: true,
  border: InputBorder.none,
  hintStyle: kSubtitle1,
);
final CheckboxThemeData kPrimaryCheckboxTheme = CheckboxThemeData(
  fillColor: const MaterialStatePropertyAll(NappyColors.primary),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4.0),
  ),
);

const IconThemeData kPrimaryIconTheme = IconThemeData(
  color: NappyColors.primaryFillText,
);

const TextSelectionThemeData kTextSelectionTheme = TextSelectionThemeData(
  cursorColor: NappyColors.primary,
  selectionHandleColor: NappyColors.selectionHandle,
  selectionColor: NappyColors.selectionColor,
);
