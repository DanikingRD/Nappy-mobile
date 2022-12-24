import 'package:nappy_mobile/auth_service_interface.dart';
import 'package:nappy_mobile/features/auth/state/auth_form_state.dart';
import 'package:nappy_mobile/value_objects.dart';
import 'package:riverpod/riverpod.dart';

class AuthController extends StateNotifier<AuthFormState> {
  final IAuthRepository _authRepository;
  AuthController(this._authRepository) : super(AuthFormState.empty());

  void onEmailChanged(String email) {
    state = state.copyWith(email: EmailAddressValue(email));
  }

  void onPasswordChanged(String password) {
    state = state.copyWith(password: PasswordValue(password));
  }

  Future<void> onRegisterWithEmailAndPassword() async {
    if (!state.email.isValid()) {
      return;
    }
    if (!state.password.isValid()) {
      return;
    }
    state = state.copyWith(isProcessing: true);
    final result = await _authRepository.registerWithEmailAndPassword(
      email: state.email,
      password: state.password,
    );
    state = state.copyWith(isProcessing: false);
  }

  Future<void> onRegisterWithGoogle() async {
    state = state.copyWith(isProcessing: true);
    final result = await _authRepository.signInWithGoogle();
    state = state.copyWith(isProcessing: false);
  }
}
