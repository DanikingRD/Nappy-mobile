// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:nappy_mobile/features/auth/views/pages/account_recovery_page.dart';
import 'package:nappy_mobile/features/auth/views/pages/login_page.dart';
import 'package:nappy_mobile/features/auth/views/pages/signup_page.dart';

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
  recovery,
}

extension AuthPageMapper on AuthPage {
  Widget toWidget() {
    switch (this) {
      case AuthPage.login:
        return const LoginPage();
      case AuthPage.signup:
        return const SignupPage();
      case AuthPage.recovery:
        return const AccountRecoveryPage();
    }
  }
}
