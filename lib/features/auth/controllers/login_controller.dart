import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/util/auth.dart';
import 'package:nappy_mobile/common/util/connection.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/value/value_helper.dart';
import 'package:nappy_mobile/features/auth/states/login_form.dart';
import 'package:nappy_mobile/features/auth/views/widgets/auth_dialogs.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/repositories/impl/auth_repository.dart';
import 'package:nappy_mobile/repositories/impl/user_repository.dart';
import 'package:nappy_mobile/repositories/interfaces/auth_facade.dart';
import 'package:nappy_mobile/router.dart';
import 'package:routemaster/routemaster.dart';

final loginControllerProvider = StateNotifierProvider.autoDispose<LoginController, LoginForm>(
  (ref) {
    return LoginController(
      authService: ref.watch(authRepositoryProvider),
      logger: NappyLogger.getLogger((LoginController).toString()),
      ref: ref,
    );
  },
  name: (LoginController).toString(),
);

class LoginController extends StateNotifier<LoginForm> {
  final IAuthRepositoryFacade _authInterface;
  final NappyLogger _logger;
  final Ref _ref;

  LoginController({
    required IAuthRepositoryFacade authService,
    required NappyLogger logger,
    required Ref ref,
  })  : _authInterface = authService,
        _logger = logger,
        _ref = ref,
        super(
          LoginForm.empty(),
        );

  Future<Unit> signInWithGoogle(BuildContext context) async {
    final connection = await handleConnectionError(context);
    if (!connection) {
      return unit;
    }
    // Do not show loading indicator when signing in with google.
    final res = await _authInterface.signInWithGoogle();
    res.match(
      (exception) {
        AuthDialogs.onAuthError(exception, context);
      },
      (user) {
        //   setActiveUser(user);
        //  AuthDialogs.onAuthSuccess(context);
      },
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
    final res = await _authInterface.signIn(
      email: emailVal,
      password: passwordVal,
    );
    res.match(
      (exception) {
        setIdle();
        AuthDialogs.onAuthError(exception, context);
      },
      (user) {
        // Not need to call setIdle() here as the view is automatically redirected
        // to the home page before it even runs.
        // Otherwise it will throw an error saying that the widget was disposed..
      },
    );
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
