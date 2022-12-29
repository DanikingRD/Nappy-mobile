// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class AuthPageState {
  final AuthPage activePage;
  const AuthPageState({
    required this.activePage,
  });

  factory AuthPageState.init() {
    return const AuthPageState(
      activePage: AuthPage.login,
    );
  }

  AuthPageState copyWith({
    AuthPage? activePage,
  }) {
    return AuthPageState(
      activePage: activePage ?? this.activePage,
    );
  }
}

enum AuthPage {
  login,
  signup,
}
