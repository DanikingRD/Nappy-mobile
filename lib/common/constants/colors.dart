import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/util/notification.dart';

class NappyColors {
  static const Map<NotificationType, Color> notificationColorMap = {
    NotificationType.info: NappyColors.info,
    NotificationType.error: NappyColors.danger,
    NotificationType.success: NappyColors.success,
  };

  static const Color primary = Color(0xFFFB7B7B);
  static const Color primaryFill = Color(0xFFFCF3F3);
  static const Color primaryFillText = Color(0xFFB29696);
  static const Color selectionColor = Color.fromARGB(255, 255, 193, 193);
  static const Color selectionHandle = Color.fromARGB(255, 255, 74, 102);
  static const Color mutedText = Color.fromARGB(255, 169, 179, 183);
  static const Color dark = Color.fromRGBO(53, 57, 59, 1);
  static const Color divider = Color.fromARGB(255, 125, 125, 125);
  static const Color landing = Color.fromARGB(255, 255, 160, 160);
  static const Color danger = Color.fromARGB(255, 253, 107, 107);
  static const Color success = Color(0xff48c774);
  static const Color info = Color(0xFF64B5F6);
}
