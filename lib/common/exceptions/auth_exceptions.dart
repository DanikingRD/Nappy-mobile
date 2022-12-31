import 'package:nappy_mobile/common/util/logger.dart';

/// Authentication related failures.
enum AuthExceptionOutput {
  /// Thrown if there already exists an account with the given email address.
  emailAlreadyExists("Email taken", "This email is already being used"),

  /// Thrown if the email address is not valid.
  invalidEmail("Invalid Email", "The email you've entered is invalid"),

  /// Thrown if the password is not strong enough.
  weakPassword(
    "Weak Password",
    "Your password must be at least 6 characters long.",
  ),

  /// Thrown if the email is not registered.
  accountNotFound("User not found", "Check your email and try again."),

  /// Thrown if the entered password was wrong.
  wrongPassword(
    "Invalid Credentials",
    "You have entered an invalid email or password.",
  ),

  /// Thrown if email/password accounts are not enabled in the backend.
  opNotAllowed("Operation Not Allowed", "Contact with support."),

  /// Thrown if the operation was canceled by the user. (E.g Google Auth popup was closed).
  canceledByUser("Canceled By User", "The operation was canceled by the user"),

  /// Thrown if none of the previous errors were matched.
  unknownError("Unknown Error", "Contact with support."),
  ;

  final String title;
  final String description;
  const AuthExceptionOutput(this.title, this.description);
}

class AuthException {
  const AuthException._();
  static const _authExceptions = {
    'email-already-in-use': AuthExceptionOutput.emailAlreadyExists,
    'invalid-email': AuthExceptionOutput.invalidEmail,
    'weak-password': AuthExceptionOutput.weakPassword,
    'user-not-found': AuthExceptionOutput.accountNotFound,
    'wrong-password': AuthExceptionOutput.wrongPassword,
    'operation-not-allowed': AuthExceptionOutput.opNotAllowed,
    'popup-closed-by-user': AuthExceptionOutput.canceledByUser,
    'undefined': AuthExceptionOutput.unknownError,
  };

  static AuthExceptionOutput mapCode(String code) {
    final val = _authExceptions[code];
    final output = val ?? AuthExceptionOutput.unknownError;
    NappyLogger.getLogger((AuthException).toString()).i(
      'Exception $code was thrown: ${output.description}',
    );
    return output;
  }
}
