enum ViewState { loading, error, idle }

extension ViewStateExtension on ViewState {
  bool get isLoading => this == ViewState.loading;
  bool get hasError => this == ViewState.error;
  bool get isIdle => this == ViewState.idle;
}

abstract class ControllerState<T> {
  final ViewState viewState;
  final T state;

  const ControllerState({
    required this.viewState,
    required this.state,
  });

  T getState() => state;
  ViewState get view => viewState;
  bool get isLoading => viewState.isLoading;
  bool get isIdle => viewState.isIdle;
  bool get hasError => viewState.hasError;
}
