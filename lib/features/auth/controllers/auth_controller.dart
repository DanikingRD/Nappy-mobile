import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/auth_form.dart';
import 'package:nappy_mobile/auth_repository.dart';
import 'package:nappy_mobile/exceptions/value_exceptions.dart';
import 'package:nappy_mobile/util/auth_error.dart';
import 'package:nappy_mobile/util/auth_interface.dart';
import 'package:nappy_mobile/util/logger.dart';
import 'package:nappy_mobile/value/email_address_value.dart';
import 'package:nappy_mobile/value/password_value.dart';
import 'package:nappy_mobile/widgets/dialog_box.dart';

final authControllerProvider = StateNotifierProvider<AuthController, AuthForm>(
  (ref) {
    return AuthController(
        repository: ref.read(authRepositoryProvider),
        logger: NappyLogger.getLogger((AuthController).toString()));
  },
  name: (AuthController).toString(),
);

final authStateChangesProvider = StreamProvider(
  (ref) {
    return ref.watch(authRepositoryProvider).onAuthStateChanged();
  },
  name: 'AuthListener',
);

class AuthController extends StateNotifier<AuthForm> {
  final IAuthRepository _repository;
  final NappyLogger _logger;

  AuthController({
    required IAuthRepository repository,
    required NappyLogger logger,
  })  : _repository = repository,
        _logger = logger,
        super(AuthForm.empty());

  /// Log debugging exceptions
  void handleDebugLog({
    required String element,
    required String code,
    required String desc,
  }) {
    _logger.d('[$element] has thrown exception code [$code]: $desc');
  }

  Option<EmailAddressValue> handleEmail(BuildContext ctx, String? email) {
    try {
      return Option.of(EmailAddressValue(email));
    } on RequiredValueException catch (e) {
      DialogBox.show(
        context: ctx,
        title: "Email Field",
        content: "You haven't entered an email yet. Enter one and try again.",
        continueText: "OK",
        type: DialogType.error,
      );
      handleDebugLog(code: e.code, desc: e.message, element: "Email Field");
      return Option.none();
    } on IllegalValueException catch (e) {
      DialogBox.show(
        context: ctx,
        title: "Email Field",
        content: "The email you've entered is invalid. Enter a valid email and try again.",
        continueText: "OK",
        type: DialogType.error,
      );
      handleDebugLog(code: e.code, desc: e.message, element: "Email Field");
      return Option.none();
    }
  }

  Option<PasswordValue> handlePassword(BuildContext ctx, String? password) {
    try {
      return Option.of(PasswordValue(password));
    } on RequiredValueException catch (e) {
      DialogBox.show(
        context: ctx,
        title: "Password Field",
        content: "You haven't entered any password yet. Enter one and try again.",
        continueText: "OK",
        type: DialogType.error,
      );
      handleDebugLog(code: e.code, desc: e.message, element: "Password Field");
      return Option.none();
    } on TooShortValueException catch (e) {
      DialogBox.show(
        context: ctx,
        title: "Invalid Password",
        content: "Make sure your password is at least 6 characters long and try again.",
        continueText: "OK",
        type: DialogType.error,
      );
      handleDebugLog(code: e.code, desc: e.message, element: "Password Field");
      return Option.none();
    }
  }

  void onAuthError(AuthError e, BuildContext ctx) {
    DialogBox.show(
      context: ctx,
      title: e.title,
      content: e.description,
      continueText: "GOT IT",
      type: DialogType.error,
    );
      handleDebugLog(code: e.code, desc: e.description, element: (AuthController).toString());
  }

  void onAuthSuccess(BuildContext context) {
    DialogBox.show(
      context: context,
      title: "Great!",
      content: "Your account has been created successfully.",
      continueText: "Start Exploreing Nappy",
      type: DialogType.success,
    );
  }

  Future<Unit> signInWithGoogle(BuildContext context) async {
    final response = await _repository.signInWithGoogle();
    response.match((AuthError error) => onAuthError(error, context), (_) => onAuthSuccess(context));
    return unit;
  }

  Future<Unit> signIn(BuildContext context) async {
    final optionalEmail = handleEmail(context, state.email);
    final optionalPassword = handlePassword(context, state.password);
    if (optionalEmail.isNone()) {
      return unit;
    } else if (optionalPassword.isNone()) {
      return unit;
    }
    final emailVal = optionalEmail.getOrElse(() => throw 'This should not happen');
    final passwordVal = optionalPassword.getOrElse(() => throw 'This is impossible');
    state = state.copyWith(loading: true);
    final response = await _repository.signIn(email: emailVal, password: passwordVal);
    state = state.copyWith(loading: false);
    response.match((AuthError error) => onAuthError(error, context), (_) => onAuthSuccess(context));
    return unit;
  }

  Future<Unit> register(BuildContext context) async {
    final optionalEmail = handleEmail(context, state.email);
    final optionalPassword = handlePassword(context, state.password);
    if (optionalEmail.isNone()) {
      return unit;
    } else if (optionalPassword.isNone()) {
      return unit;
    }
    final emailVal = optionalEmail.getOrElse(() => throw 'This should not happen');
    final passwordVal = optionalPassword.getOrElse(() => throw 'This is impossible');
    state = state.copyWith(loading: true);
    final response = await _repository.register(email: emailVal, password: passwordVal);
    state = state.copyWith(loading: false);
    response.match((AuthError error) => onAuthError(error, context), (_) => onAuthSuccess(context));
    return unit;
  }

  void onEmailUpdate(String? email) {
    state = state.copyWith(email: email);
  }

  void onPasswordUpdate(String? pw) {
    state = state.copyWith(password: pw);
  }
}
