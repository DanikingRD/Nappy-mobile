import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/auth_repository.dart';
import 'package:nappy_mobile/util/auth_error.dart';
import 'package:nappy_mobile/util/auth_interface.dart';
import 'package:nappy_mobile/util/logger.dart';
import 'package:nappy_mobile/value/email_address_value.dart';
import 'package:nappy_mobile/value/password_value.dart';

final authServiceProvider = Provider(
  (ref) {
    return AuthService(
      authService: ref.read(authRepositoryProvider),
      logger: NappyLogger.getLogger((AuthService).toString()),
    );
  },
  name: (AuthService).toString(),
);
final authStateChangesProvider = StreamProvider(
  (ref) {
    return ref.watch(authRepositoryProvider).onAuthStateChanged();
  },
  name: (AuthService).toString(),
);

class AuthService {
  final IAuthRepository _repository;
  final NappyLogger _logger;

  const AuthService({
    required IAuthRepository authService,
    required NappyLogger logger,
  })  : _repository = authService,
        _logger = logger;

  Future<Unit> signInWithGoogle({
    required void Function(AuthError) onError,
    required VoidCallback onSuccess,
  }) async {
    final response = await _repository.signInWithGoogle();
    return response.match(
      (err) {
        _logger.handleDebugLog(
          code: err.code,
          desc: err.description,
          element: (AuthService).toString(),
        );
        onError(err);
        return unit;
      },
      (_) {
        onSuccess();
        return unit;
      },
    );
  }

  Future<Unit> signIn({
    required EmailAddressValue email,
    required PasswordValue password,
    required void Function(AuthError error) onError,
    required VoidCallback onSuccess,
  }) async {
    final response = await _repository.signIn(
      email: email,
      password: password,
    );
    return response.match(
      (err) {
        _logger.handleDebugLog(
          code: err.code,
          desc: err.description,
          element: (AuthService).toString(),
        );
        onError(err);
        return unit;
      },
      (_) {
        onSuccess();
        return unit;
      },
    );
  }

  Future<Unit> register({
    required EmailAddressValue email,
    required PasswordValue password,
    required void Function(AuthError error) onError,
    required VoidCallback onSuccess,
  }) async {
    final response = await _repository.register(
      email: email,
      password: password,
    );
    return response.match(
      (err) {
        _logger.handleDebugLog(
          code: err.code,
          desc: err.description,
          element: (AuthService).toString(),
        );
        onError(err);
        return unit;
      },
      (_) {
        onSuccess();
        return unit;
      },
    );
  }
}
