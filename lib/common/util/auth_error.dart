import 'package:nappy_mobile/common/util/logger.dart';

/// Authentication related errors.
enum AuthError {
  /// Thrown if there already exists an account with the given email address.
  emailAlreadyExists('email-already-in-use', "This emails is already being used", ""),

  /// Thrown if the email address is not valid.
  invalidEmail('invalid-email', "Invalid Email", "The email you've entered is invalid"),

  /// Thrown if the password is not strong enough.
  weakPassword(
    'weak-password',
    "Weak Password",
    "Your password must be at least 6 characters long.",
  ),

  /// Thrown if the email is not registered.
  accountNotFound('user-not-found', "User not found", "Check your email and try again."),

  /// Thrown if email/password accounts are not enabled in the backend.
  opNotAllowed('operation-not-allowed', "Operation Not Allowed", "Contact with support."),

  /// Thrown if none of the previous errors were matched.
  serverError('undefined', "Unknown Error", "Contact with support."),

  /// Thrown if the operation was canceled by the user. (E.g Google Auth popup was closed).
  canceledByUser('canceled-by-user', "Canceled By User", "The operation was canceled by the user");

  final String code;
  final String title;
  final String description;
  const AuthError(this.code, this.title, this.description);
}

extension AuthErrorHelper on AuthError {
  static AuthError getByCode(String code) {
    if (code == 'popup-closed-by-user') {
      return AuthError.canceledByUser;
    }
    return AuthError.values.firstWhere(
      (element) => element.code == code,
      orElse: () => AuthError.serverError,
    );
  }
}
