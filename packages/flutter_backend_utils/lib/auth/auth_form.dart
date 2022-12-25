import 'package:flutter/cupertino.dart';
import 'package:flutter_backend_utils/flutter_backend_utils.dart';

@immutable
class AuthForm {
  final EmailAddressValue email;
  final PasswordValue password;
  final bool isLoading;
  final bool showingErrors;
  const AuthForm({
    required this.email,
    required this.password,
    required this.isLoading,
    required this.showingErrors,
  });

  factory AuthForm.empty() {
    return AuthForm(
      email: EmailAddressValue(''),
      password: PasswordValue(''),
      isLoading: false,
      showingErrors: false,
    );
  }

  AuthForm copyWith({
    EmailAddressValue? email,
    PasswordValue? password,
    bool? isLoading,
    bool? showingErrors,
  }) {
    return AuthForm(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      showingErrors: showingErrors ?? this.showingErrors,
    );
  }

  @override
  bool operator ==(covariant AuthForm other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.isLoading == isLoading &&
        other.showingErrors == showingErrors;
  }

  bool isInvalidState() {
    return email.isErr() || password.isErr();
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        isLoading.hashCode ^
        showingErrors.hashCode;
  }

  @override
  String toString() {
    return 'AuthFormState(email: $email, password: $password, isProcessing: $isLoading, showingErrors: $showingErrors)';
  }
}
