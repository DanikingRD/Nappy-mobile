import 'package:flutter/cupertino.dart';

@immutable
class SignUpForm {
  final String email;
  final String password;
  final String passwordVerification;
  final bool agreeTerms;
  final bool loading;

  const SignUpForm({
    required this.email,
    required this.password,
    required this.passwordVerification,
    required this.agreeTerms,
    required this.loading,
  });

  factory SignUpForm.empty() {
    return const SignUpForm(
      email: '',
      password: '',
      loading: false,
      agreeTerms: false,
      passwordVerification: '',
    );
  }

  SignUpForm copyWith({
    String? email,
    String? password,
    String? passwordVerification,
    bool? agreeTerms,
    bool? loading,
  }) {
    return SignUpForm(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordVerification: passwordVerification ?? this.passwordVerification,
      agreeTerms: agreeTerms ?? this.agreeTerms,
      loading: loading ?? this.loading,
    );
  }

  @override
  String toString() {
    return 'SignUpForm(email: $email, password: $password, passwordVerification: $passwordVerification, agreeTerms: $agreeTerms, loading: $loading)';
  }

  @override
  bool operator ==(covariant SignUpForm other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.passwordVerification == passwordVerification &&
        other.agreeTerms == agreeTerms &&
        other.loading == loading;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        passwordVerification.hashCode ^
        agreeTerms.hashCode ^
        loading.hashCode;
  }
}
