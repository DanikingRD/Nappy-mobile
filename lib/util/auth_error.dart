/// Authentication related errors
enum AuthError {
  /// Thrown if there already exists an account with the given email address.
  emailAlreadyExists('email-already-in-use'),

  /// Thrown if the email address is not valid.
  invalidEmail('invalid-email'),

  /// Thrown if the password is not strong enough.
  weakPassword('weak-password'),

  /// Thrown if email/password accounts are not enabled in the backend.
  opNotAllowed('operation-not-allowed'),

  serverError('undefined'),
  ;

  final String code;
  const AuthError(this.code);
}

extension AuthErrorHelper on AuthError {
  static AuthError getByCode(String code) {
    return AuthError.values.firstWhere(
      (element) => element.code == code,
      orElse: () => AuthError.serverError,
    );
  }
}
