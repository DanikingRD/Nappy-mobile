// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:nappy_mobile/errors.dart';
import 'package:nappy_mobile/value_objects.dart';

@immutable
class AuthFormState {
  final EmailAddressValue email;
  final PasswordValue password;
  final bool isProcessing;
  final Option<Either<AuthError, Unit>> authHandler;
  const AuthFormState({
    required this.email,
    required this.password,
    required this.isProcessing,
    required this.authHandler,
  });

  factory AuthFormState.empty() {
    return AuthFormState(
      email: EmailAddressValue(''),
      password: PasswordValue(''),
      isProcessing: false,
      authHandler: Option.none(),
    );
  }

  AuthFormState copyWith({
    EmailAddressValue? email,
    PasswordValue? password,
    bool? isProcessing,
    Option<Either<AuthError, Unit>>? authHandler,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isProcessing: isProcessing ?? this.isProcessing,
      authHandler: authHandler ?? this.authHandler,
    );
  }

  @override
  bool operator ==(covariant AuthFormState other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.password == password &&
        other.isProcessing == isProcessing &&
        other.authHandler == authHandler;
  }

  @override
  int get hashCode {
    return email.hashCode ^ password.hashCode ^ isProcessing.hashCode ^ authHandler.hashCode;
  }

  @override
  String toString() {
    return 'AuthFormState(email: $email, password: $password, isProcessing: $isProcessing, authHandler: $authHandler)';
  }
}
