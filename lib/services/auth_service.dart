import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/auth_repository.dart';
import 'package:nappy_mobile/common/util/auth_error.dart';
import 'package:nappy_mobile/common/util/auth_facade.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/value/email_address_value.dart';
import 'package:nappy_mobile/common/value/password_value.dart';

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
  final IAuthRepositoryFacade _repository;
  final NappyLogger _logger;

  const AuthService({
    required IAuthRepositoryFacade authService,
    required NappyLogger logger,
  })  : _repository = authService,
        _logger = logger;

  Future<Unit> sendResetPasswordLink({
    required void Function(AuthError error) onError,
    required VoidCallback onSuccess,
    required EmailAddressValue email,
  }) async {
    final response = await _repository.sendResetPasswordLink(email);
    return response.match(
      (err) {
        _logger.handleDebugLogErr(
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

  Future<Unit> signInWithGoogle({
    required void Function(AuthError error) onError,
    required VoidCallback onSuccess,
  }) async {
    final response = await _repository.signInWithGoogle();
    return response.match(
      (err) {
        _logger.handleDebugLogErr(
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
        _logger.handleDebugLogErr(
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
        _logger.handleDebugLogErr(
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
