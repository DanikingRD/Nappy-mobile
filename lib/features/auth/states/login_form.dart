import 'package:flutter/cupertino.dart';

@immutable
class LoginForm {
  final String? email;
  final String? password;
  final bool loading;
  const LoginForm({
    required this.email,
    required this.password,
    required this.loading,
  });

  factory LoginForm.empty() {
    return const LoginForm(
      email: '',
      password: '',
      loading: false,
    );
  }
  LoginForm copyWith({
    String? email,
    String? password,
    bool? loading,
  }) {
    return LoginForm(
      email: email ?? this.email,
      password: password ?? this.password,
      loading: loading ?? this.loading,
    );
  }
  
  @override
  bool operator ==(covariant LoginForm other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password && other.loading == loading;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ loading.hashCode;

  @override
  String toString() => 'LoginForm(email: $email, password: $password, loading: $loading)';
}
