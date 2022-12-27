import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/auth_form.dart';
import 'package:nappy_mobile/auth_repository.dart';
import 'package:nappy_mobile/exceptions/value_exceptions.dart';
import 'package:nappy_mobile/util/auth_interface.dart';
import 'package:nappy_mobile/value/email_address_value.dart';
import 'package:nappy_mobile/value/password_value.dart';
import 'package:nappy_mobile/widgets/dialog_box.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, AuthForm>((ref) {
  return LoginController(ref.read(authRepositoryProvider));
});

class LoginController extends StateNotifier<AuthForm> {
  final IAuthRepository repository;

  LoginController(this.repository) : super(AuthForm.empty());

  Option<EmailAddressValue> handleEmail(BuildContext ctx, String? email) {
    // TODO: log errors
    try {
      return Option.of(EmailAddressValue(email));
    } on RequiredValueException catch (e) {
      DialogBox.show(
        context: ctx,
        title: "Email Field",
        content: "You haven't entered an email yet. Enter one and try again.",
        continueText: "OK",
      );
      return Option.none();
    } on IllegalValueException catch (e) {
      DialogBox.show(
        context: ctx,
        title: "Email Field",
        content: "The email you've entered is invalid. Enter a valid email and try again.",
        continueText: "OK",
      );
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
      );
      return Option.none();
    } on TooShortValueException catch (e) {
      DialogBox.show(
        context: ctx,
        title: "Invalid Password",
        content: "Make sure your password is at least 6 characters long and try again.",
        continueText: "OK",
      );
      return Option.none();
    }
  }

  Future<void> register(BuildContext context) async {
    final optionalEmail = handleEmail(context, state.email);
    final optionalPassword = handlePassword(context, state.password);
    if (optionalEmail.isNone()) {
      return;
    } else if (optionalPassword.isNone()) {
      return;
    }
    final emailVal = optionalPassword.getOrElse(() => throw 'This should not happen');
    final passwordVal = optionalEmail.getOrElse(() => throw 'This is impossible');
  }

  void onEmailUpdate(String? email) {
    state = state.copyWith(email: email);
  }

  void onPasswordUpdate(String? pw) {
    state = state.copyWith(password: pw);
    print(pw);
  }
}
