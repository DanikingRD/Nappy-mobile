import 'package:flutter/cupertino.dart';
import 'package:nappy_mobile/common/error/auth_error.dart';
import 'package:nappy_mobile/common/util/notification.dart';
import 'package:nappy_mobile/common/widgets/dialog_box.dart';

class AuthDialogs {
  const AuthDialogs._();
  static Future<T?> onAuthError<T>(AuthError e, BuildContext ctx) {
    return DialogBox.show(
      context: ctx,
      title: e.title,
      content: e.description,
      continueText: "GOT IT",
      type: NotificationType.error,
    );
  }

  static Future<T?> onEmailVerificationSent<T>(BuildContext context) {
    return DialogBox.show(
      context: context,
      title: "Password reset link sent!",
      content: "Check your inbox for the link to reset your password.",
      continueText: "Continue",
      type: NotificationType.success,
    );
  }

  static Future<T?> onAuthSuccess<T>(BuildContext context) {
    return DialogBox.show(
      context: context,
      title: "Welcome Back!",
      content: "It's nice to see you again!",
      continueText: "Continue",
      type: NotificationType.success,
    );
  }
}
