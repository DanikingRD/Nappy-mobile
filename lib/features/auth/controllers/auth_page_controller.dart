import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/features/auth/states/auth_page.dart';

final authPageControllerProvider = StateNotifierProvider<AuthPageController, AuthPage>((ref) {
  return AuthPageController();
});

class AuthPageController extends StateNotifier<AuthPage> {
  AuthPageController() : super(AuthPage.login);

  void showLogin() {
    state = AuthPage.login;
  }

  void showSignUp() {
    state = AuthPage.signup;
  }
}
