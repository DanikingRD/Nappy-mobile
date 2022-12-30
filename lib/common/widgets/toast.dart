import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:nappy_mobile/common/constants/colors.dart';
import 'package:nappy_mobile/common/util/connection.dart';
import 'package:nappy_mobile/common/util/notification.dart';
import 'package:nappy_mobile/common/util/responsive.dart';

void showToast({
  required String message,
  required NotificationType type,
  required BuildContext context,
}) {
  buildToast(message: message, type: type, context: context).show(context);
}

Flushbar buildToast({
  required String message,
  required NotificationType type,
  required BuildContext context,
  Duration animationDuration = const Duration(milliseconds: 500),
  Duration duration = const Duration(seconds: 3),
}) {
  final isMobile = Responsive.isSmallScreen(context);
  return Flushbar(
    message: message,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: NappyColors.notificationColorMap[type],
    ),
    borderRadius: BorderRadius.circular(8.0),
    duration: duration,
    leftBarIndicatorColor: NappyColors.notificationColorMap[type],
    maxWidth: isMobile ? null : 450,
    animationDuration: animationDuration,
    margin: const EdgeInsets.all(10.0),
  );
}
