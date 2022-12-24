import 'package:nappy_mobile/auth_service_interface.dart';
import 'package:nappy_mobile/features/auth/state/auth_form_state.dart';
import 'package:riverpod/riverpod.dart';

class AuthController extends StateNotifier<AuthFormState> {
  final IAuthRepository _authRepository;
  AuthController(this._authRepository) : super(AuthFormState.empty());
}
