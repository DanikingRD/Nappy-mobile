import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_backend_utils/flutter_backend_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:nappy_mobile/auth_repository.dart';
import 'package:nappy_mobile/features/auth/states/login_view_state.dart';
import 'package:nappy_mobile/util/logger.dart';

final loginControllerProvider = StateNotifierProvider<LoginController, LoginViewState>((ref) {
  return LoginController(ref.read(authRepositoryProvider));
});

class LoginController extends StateNotifier<LoginViewState> {
  final IAuthRepository repository;

  LoginController(this.repository) : super(LoginViewState.idle());

  Future<Unit> signInWithGoogle() async {
  
    final log = NappyLogger.getLogger('className');
    final output = await repository.signInWithGoogle();
    state = LoginViewState.idle();
    output.match(
      (err) => {},
      (_) => {},
    );
    return unit;
  }

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
