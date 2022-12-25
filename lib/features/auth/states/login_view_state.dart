import 'package:flutter_backend_utils/flutter_backend_utils.dart';
import 'package:fpdart/fpdart.dart';

class LoginViewState extends ControllerState<Unit> {
  const LoginViewState({
    required super.viewState,
    required super.state,
  });

  factory LoginViewState.idle() {
    return const LoginViewState(viewState: ViewState.idle, state: unit);
  }

  factory LoginViewState.loading() {
    return const LoginViewState(viewState: ViewState.loading, state: unit);
  }
  factory LoginViewState.error() {
    return const LoginViewState(viewState: ViewState.error, state: unit);
  }
}
