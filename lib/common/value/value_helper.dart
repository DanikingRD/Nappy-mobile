import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/exceptions/value_exceptions.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/util/notification.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/password_value.dart';
import 'package:nappy_mobile/common/widgets/dialog_box.dart';

class ValueHelper {
  const ValueHelper._();

  static Option<EmailAddressValue> handleEmail({
    required BuildContext context,
    required String? email,
    required NappyLogger logger,
  }) {
    try {
      return Option.of(EmailAddressValue(email));
    } on RequiredValueException catch (e) {
      DialogBox.show(
        context: context,
        title: "Email Field",
        content: "You haven't entered an email yet. Enter one and try again.",
        continueText: "OK",
        type: NotificationType.error,
      );
      logger.handleDebugLogErr(code: e.code, desc: e.message, element: "Email Field");
      return Option.none();
    } on IllegalValueException catch (e) {
      DialogBox.show(
        context: context,
        title: "Email Field",
        content: "The email you've entered is invalid. Enter a valid email and try again.",
        continueText: "OK",
        type: NotificationType.error,
      );
      logger.handleDebugLogErr(code: e.code, desc: e.message, element: "Email Field");
      return Option.none();
    }
  }

  static Option<PasswordValue> handlePassword({
    required BuildContext context,
    required String? password,
    required NappyLogger logger,
    bool verification = false,
  }) {
    final String field = verification ? "Password Verification Field" : "Password Field";
    // Note: do not show dialogs if this is a verification password
    // since the caller should show an error if they do not match
    try {
      return Option.of(PasswordValue(password));
    } on RequiredValueException catch (e) {
      if (!verification) {
        DialogBox.show(
          context: context,
          title: field,
          content: "You haven't entered any password yet. Enter one and try again.",
          continueText: "OK",
          type: NotificationType.error,
        );
      }
      logger.handleDebugLogErr(code: e.code, desc: e.message, element: field);
      return Option.none();
    } on TooShortValueException catch (e) {
      if (!verification) {
        DialogBox.show(
          context: context,
          title: "Invalid Password",
          content: "Make sure your password is at least 6 characters long and try again.",
          continueText: "OK",
          type: NotificationType.error,
        );
      }
      logger.handleDebugLogErr(code: e.code, desc: e.message, element: field);
      return Option.none();
    }
  }
}
