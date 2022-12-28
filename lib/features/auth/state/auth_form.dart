import 'package:flutter/cupertino.dart';

@immutable
class AuthForm {
  final String? email;
  final String? password;
  final bool loading;
  const AuthForm({
    required this.email,
    required this.password,
    required this.loading,
  });

  factory AuthForm.empty() {
    return const AuthForm(
      email: '',
      password: '',
      loading: false,
    );
  }
  AuthForm copyWith({
    String? email,
    String? password,
    bool? loading,
  }) {
    return AuthForm(
      email: email ?? this.email,
      password: password ?? this.password,
      loading: loading ?? this.loading,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'loading': loading,
    };
  }

  factory AuthForm.fromMap(Map<String, dynamic> map) {
    return AuthForm(
      email: map['email'] as String,
      password: map['password'] as String,
      loading: map['loading'] as bool,
    );
  }

  @override
  String toString() => 'AuthView(email: $email, password: $password, loading: $loading)';

  @override
  bool operator ==(covariant AuthForm other) {
    if (identical(this, other)) return true;

    return other.email == email && other.password == password && other.loading == loading;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ loading.hashCode;
}
