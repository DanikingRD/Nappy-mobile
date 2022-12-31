abstract class BackendError {
  const BackendError();
  String get code;
  String get title;
  String get description;
}

class AuthError extends BackendError {
  static const String _emailAlreadyInUseCode = "email-already-in-use";
  static const String _invalidEmailCode = "invalid-email";
  static const String _weakPasswordCode = "weak-password";
  static const String _userNotFoundCode = "user-not-found";
  static const String _wrongPasswordCode = "wrong-password";
  static const String _opNotAllowedCode = "operation-not-allowed";
  static const String _popupClosedByUserCode = "popup-closed-by-user";

  @override
  final String code;
  @override
  final String title;
  @override
  final String description;
  // AuthError constructor
  const AuthError({
    required this.code,
    required this.title,
    required this.description,
  });

  static const emailAlreadyInUse = AuthError(
    code: _emailAlreadyInUseCode,
    title: "Email Taken",
    description: "This email is already being used.",
  );

  static const invalidEmail = AuthError(
    code: _invalidEmailCode,
    title: "Invalid Email",
    description: "The email you've entered is invalid.",
  );
  static const weakPassword = AuthError(
    code: _weakPasswordCode,
    title: "Weak Password",
    description: "Your password must be at least 6 characters long.",
  );

  static const accountNotFound = AuthError(
    code: _userNotFoundCode,
    title: "Account not found",
    description: "Check your email and try again.",
  );

  static const wrongPassword = AuthError(
    code: _wrongPasswordCode,
    title: "Invalid Credentials",
    description: "You have entered an invalid email or password.",
  );
  static const opNotAllowed = AuthError(
    code: _opNotAllowedCode,
    title: "Operation Not Allowed",
    description: "Contact with support.",
  );
  static const closedByUser = AuthError(
    code: _popupClosedByUserCode,
    title: "Canceled By User",
    description: "The operation was canceled by the user.",
  );
  static const unknown = AuthError(
    code: "unknown",
    title: "Unknown Error",
    description: "Contact with support.",
  );

  static BackendError mapCode(String code) {
    switch (code) {
      case _emailAlreadyInUseCode:
        return emailAlreadyInUse;
      case _invalidEmailCode:
        return invalidEmail;
      case _weakPasswordCode:
        return weakPassword;
      case _userNotFoundCode:
        return accountNotFound;
      case _wrongPasswordCode:
        return wrongPassword;
      case _opNotAllowedCode:
        return opNotAllowed;
      case _popupClosedByUserCode:
        return closedByUser;
      default:
        return unknown;
    }
  }
}

class DatabaseError extends BackendError {
  @override
  final String code;
  @override
  final String title;
  @override
  final String description;
  // AuthError constructor
  const DatabaseError({
    required this.code,
    required this.title,
    required this.description,
  });
  static const unknown = DatabaseError(
    code: "unknown",
    title: "Unknown Error",
    description: "Contact with support",
  );
  static BackendError mapCode(String code) {
    switch (code) {
      default:
        return unknown;
    }
  }
}
