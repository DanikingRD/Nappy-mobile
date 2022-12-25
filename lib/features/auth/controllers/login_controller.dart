import 'package:flutter_backend_utils/flutter_backend_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/features/auth/states/login_view_state.dart';

class LoginController extends StateNotifier<LoginViewState> {
  final IAuthRepository repository;

  LoginController(this.repository) : super(LoginViewState.idle());

  Future<Unit> signIn({
    required String email,
    required String password,
  }) async {
    final emailVal = EmailAddressValue(email);
    final passwordVal = PasswordValue(password);
    state = LoginViewState.loading();
    final result = await repository.signInWithEmail(
      email: emailVal,
      password: passwordVal,
    );
    state = LoginViewState.idle();
    result.match(
      (error) => null,
      (_) => null,
    );
    return unit;
  }
}
