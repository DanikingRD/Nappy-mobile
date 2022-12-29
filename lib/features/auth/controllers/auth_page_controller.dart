import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nappy_mobile/features/auth/states/auth_page.dart';

final authPageControllerProvider = StateNotifierProvider<AuthPageController, AuthPageState>((ref) {
  return AuthPageController();
});

class AuthPageController extends StateNotifier<AuthPageState> {
  AuthPageController() : super(AuthPageState.init());

  void showLogin() {
    state = state.copyWith(activePage: AuthPage.login);
  }

  void showSignUp() {
    state = state.copyWith(activePage: AuthPage.signup);
  }
}
