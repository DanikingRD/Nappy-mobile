import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/features/auth/states/login_form.dart';
import 'package:nappy_mobile/services/auth_service.dart';
import 'package:nappy_mobile/util/auth_error.dart';
import 'package:nappy_mobile/util/connection.dart';
import 'package:nappy_mobile/util/extensions.dart';
import 'package:nappy_mobile/util/logger.dart';
import 'package:nappy_mobile/util/notification.dart';
import 'package:nappy_mobile/value/value_helper.dart';
import 'package:nappy_mobile/widgets/dialog_box.dart';

final loginControllerProvider = StateNotifierProvider.autoDispose<LoginController, LoginForm>(
  (ref) {
    return LoginController(
      authService: ref.read(authServiceProvider),
      logger: NappyLogger.getLogger((LoginController).toString()),
    );
  },
  name: (LoginController).toString(),
);

class LoginController extends StateNotifier<LoginForm> {
  final AuthService _authService;
  final NappyLogger _logger;

  LoginController({
    required AuthService authService,
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
    await _authService.signInWithGoogle(
      onError: (error) => onAuthError(error, context),
      onSuccess: () => onAuthSuccess(context),
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
    await _authService.signIn(
      email: emailVal,
      password: passwordVal,
      onError: (AuthError error) => onAuthError(error, context),
      onSuccess: () => onAuthSuccess(context),
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

  void onAuthError(AuthError e, BuildContext ctx) {
    DialogBox.show(
      context: ctx,
      title: e.title,
      content: e.description,
      continueText: "GOT IT",
      type: NotificationType.error,
    );
  }

  void onAuthSuccess(BuildContext context) {
    DialogBox.show(
      context: context,
      title: "Welcome Back!",
      content: "It's nice to see you again!",
      continueText: "Continue",
      type: NotificationType.success,
    );
  }

  void onEmailUpdate(String? email) {
    state = state.copyWith(email: email);
  }

  void onPasswordUpdate(String? pw) {
    state = state.copyWith(password: pw);
  }
}
