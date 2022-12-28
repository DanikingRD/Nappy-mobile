import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/features/auth/states/signup_form.dart';
import 'package:nappy_mobile/services/auth_service.dart';
import 'package:nappy_mobile/util/auth_error.dart';
import 'package:nappy_mobile/util/extensions.dart';
import 'package:nappy_mobile/util/logger.dart';
import 'package:nappy_mobile/util/notification.dart';
import 'package:nappy_mobile/value/value_helper.dart';
import 'package:nappy_mobile/widgets/dialog_box.dart';
import 'package:nappy_mobile/widgets/toast.dart';

final signUpControllerProvider = StateNotifierProvider<SignUpController, SignUpForm>(
  (ref) {
    return SignUpController(
      authService: ref.read(authServiceProvider),
      logger: NappyLogger.getLogger((SignUpController).toString()),
    );
  },
  name: (SignUpController).toString(),
);

class SignUpController extends StateNotifier<SignUpForm> {
  final AuthService _authService;
  final NappyLogger _logger;

  SignUpController({
    required AuthService authService,
    required NappyLogger logger,
  })  : _authService = authService,
        _logger = logger,
        super(SignUpForm.empty());

  Future<void> register(BuildContext context) async {
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
      return;
    }
    if (!state.agreeTerms) {
      showToast(
        message: "You must accept the Terms of Service to create an account.",
        type: NotificationType.info,
        context: context,
      );
      return;
    }
    final emailVal = email.getOrThrow();
    final passwordVal = password.getOrThrow();
    setLoading();
    await _authService.register(
      email: emailVal,
      password: passwordVal,
      onError: (error) => handleError(error, context),
      onSuccess: () => handleSuccess(context),
    );
    setIdle();
  }

  void handleError(AuthError e, BuildContext ctx) {
    DialogBox.show(
      context: ctx,
      title: e.title,
      content: e.description,
      continueText: "GOT IT",
      type: NotificationType.error,
    );
  }

  void handleSuccess(BuildContext context) {
    DialogBox.show(
      context: context,
      title: "Great!",
      content: "Your account has been created successfully.",
      continueText: "Start Exploring Nappy",
      type: NotificationType.success,
    );
  }

  void onEmailUpdate(String? email) {
    state = state.copyWith(email: email);
  }

  void onPasswordUpdate(String? pw) {
    state = state.copyWith(password: pw);
  }

  void onVerifyPasswordUpdate(String? pw) {
    state = state.copyWith(passwordVerification: pw);
  }

  void setLoading() {
    state = state.copyWith(loading: true);
  }

  void setIdle() {
    state = state.copyWith(loading: false);
  }

  void setAgreeTerms(bool? val) {
    // If Checkbox is not disabled
    if (val != null) {
      state = state.copyWith(agreeTerms: val);
    }
  }
}
