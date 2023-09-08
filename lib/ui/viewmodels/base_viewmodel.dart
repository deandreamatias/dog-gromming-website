import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseViewModel<T extends ViewState> extends Cubit<T> {
  BaseViewModel(super.initialState) {
    onAttach();
  }

  void emitValue(T state) {
    super.emit(state);
  }

  void onAttach();
}

abstract class ViewState {
  const ViewState();
}
