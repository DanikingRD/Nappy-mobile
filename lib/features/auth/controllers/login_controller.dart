import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/util/connection.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/value/value_helper.dart';
import 'package:nappy_mobile/features/auth/states/login_form.dart';
import 'package:nappy_mobile/features/auth/views/widgets/auth_dialogs.dart';
import 'package:nappy_mobile/repositories/impl/auth_repository.dart';
import 'package:nappy_mobile/repositories/interfaces/auth_facade.dart';

final loginControllerProvider = StateNotifierProvider.autoDispose<LoginController, LoginForm>(
  (ref) {
    return LoginController(
      authService: ref.read(authRepositoryProvider),
      logger: NappyLogger.getLogger((LoginController).toString()),
    );
  },
  name: (LoginController).toString(),
);

class LoginController extends StateNotifier<LoginForm> {
  final IAuthRepositoryFacade _authService;
  final NappyLogger _logger;

  LoginController({
    required IAuthRepositoryFacade authService,
    required NappyLogger logger,
  })  : _authService = authService,
        _logger = logger,
        super(
          LoginForm.empty(),
        );

  Future<Unit> signInWithGoogle(BuildContext context) async {
    final connection = await handleConnectionError(context);
    if (!connection) {
      return unit;
    }
    // Do not show loading indicator when signing in with google.
    final res = await _authService.signInWithGoogle();
    res.match(
      (exception) => AuthDialogs.onAuthError(exception, context),
      (_) => AuthDialogs.onAuthSuccess(context),
    );
    return unit;
  }

  Future<Unit> signIn(BuildContext context) async {
    final connection = await handleConnectionError(context);
    if (!connection) {
      return unit;
    }
    final email = ValueHelper.handleEmail(
      context: context,
      email: state.email,
      logger: _logger,
    );
    final password = ValueHelper.handlePassword(
      context: context,
      password: state.password,
      logger: _logger,
    );
    // Fast return if any of the inputs are invalid
    if (email.isNone() || password.isNone()) {
      return unit;
    }
    final emailVal = email.getOrThrow();
    final passwordVal = password.getOrThrow();
    setLoading();
    final res = await _authService.signIn(
      email: emailVal,
      password: passwordVal,
    );
    res.match(
      (exception) => AuthDialogs.onAuthError(exception, context),
      (_) => AuthDialogs.onAuthSuccess(context),
    );
    setIdle();
    return unit;
  }

  void setLoading() {
    state = state.copyWith(loading: true);
  }

  void setIdle() {
    state = state.copyWith(loading: false);
  }

  void onEmailUpdate(String? email) {
    state = state.copyWith(email: email);
  }

  void onPasswordUpdate(String? pw) {
    state = state.copyWith(password: pw);
  }
}
