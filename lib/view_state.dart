import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ViewState { loading, error, idle }

extension ViewStateExtension on ViewState {
  bool get isLoading => this == ViewState.loading;
  bool get hasError => this == ViewState.error;
  bool get isIdle => this == ViewState.idle;
}

class ViewController extends StateNotifier<ViewState> {
  ViewController() : super(ViewState.idle);

  void setLoading() {
    state = ViewState.loading;
  }

  void setIdle() {
    state = ViewState.idle;
  }

  void setError() {
    state = ViewState.error;
  }
}
