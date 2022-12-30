import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/common/exceptions/auth_exceptions.dart';
import 'package:nappy_mobile/common/util/connection.dart';
import 'package:nappy_mobile/common/util/extensions.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/util/notification.dart';
import 'package:nappy_mobile/common/value/identifier.dart';
import 'package:nappy_mobile/common/value/value_helper.dart';
import 'package:nappy_mobile/common/widgets/dialog_box.dart';
import 'package:nappy_mobile/common/widgets/toast.dart';
import 'package:nappy_mobile/features/auth/states/signup_form.dart';
import 'package:nappy_mobile/models/user.dart';
import 'package:nappy_mobile/repositories/impl/auth_repository.dart';
import 'package:nappy_mobile/repositories/impl/user_repository.dart';
import 'package:nappy_mobile/repositories/interfaces/auth_facade.dart';
import 'package:nappy_mobile/repositories/interfaces/user_facade.dart';

final signUpControllerProvider = StateNotifierProvider<SignUpController, SignUpForm>(
  (ref) {
    return SignUpController(
      authRepository: ref.read(authRepositoryProvider),
      userInterface: ref.read(userRepositoryProvider),
      logger: NappyLogger.getLogger((SignUpController).toString()),
    );
  },
  name: (SignUpController).toString(),
);

class SignUpController extends StateNotifier<SignUpForm> {
  final IAuthRepositoryFacade _authRepository;
  final IUserFacade _userInterface;
  final NappyLogger _logger;

  SignUpController({
    required IAuthRepositoryFacade authRepository,
    required IUserFacade userInterface,
    required NappyLogger logger,
  })  : _authRepository = authRepository,
        _logger = logger,
        _userInterface = userInterface,
        super(SignUpForm.empty());

  Future<Unit> register(BuildContext context) async {
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
    final passwordVerification = ValueHelper.handlePassword(
      context: context,
      password: state.passwordVerification,
      logger: _logger,
      verification: true,
    );

    // Fast return if any of the inputs are invalid
    if (email.isNone() || password.isNone() || passwordVerification.isNone()) {
      return unit;
    }
    if (password != passwordVerification) {
      DialogBox.show(
        context: context,
        title: "Password Field",
        content: "Your passwords do not match.",
        continueText: "Continue",
        type: NotificationType.error,
      );
      return unit;
    }
    if (!state.agreeTerms) {
      showToast(
        message: "You must accept the Terms of Service to create an account.",
        type: NotificationType.info,
        context: context,
      );
      return unit;
    }
    final emailVal = email.getOrThrow();
    final passwordVal = password.getOrThrow();
    setLoading();
    final result = await _authRepository.register(
      email: emailVal,
      password: passwordVal,
    );
    result.match(
      (error) => handleError(error, context),
      (_) async {
        final User user = User(
          email: emailVal.value,
          id: Identifier(),
        );
        final res = await _userInterface.create(user);
        res.match(
          (err) => handleError(AuthExceptionOutput.serverError, context),
          (_) => handleSuccess(context),
        );
      },
    );
    setIdle();
    return unit;
  }

  void handleError(AuthExceptionOutput e, BuildContext ctx) {
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
