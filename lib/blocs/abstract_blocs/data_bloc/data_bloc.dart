import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'data_event.dart';
part 'data_state.dart';

abstract class DataBloc<T extends Object> extends Bloc<DataEvent, DataState<T>> {
  DataBloc() : super(DataEmptyState<T>()) {
    on<LoadDataEvent>(_mapLoadDataEventToState);
    on<NotifyDataChangedEvent>(_mapNotifyDataChangedEventToState);
  }

  T? value;

  Future<void> _mapLoadDataEventToState(LoadDataEvent event, Emitter<DataState<T>> emit) async {
    emit(DataLoadingState<T>());

    if (value == null) {
      value = await fetchCacheData();
      if (value != null) {
        emit(DataLoadedState<T>(value!));
      }
    }
    try {
      value = await fetchRemoteData();
      emit(DataLoadedState<T>(value!));
    } catch (e) {
      emit(DataErrorState<T>());
    }
  }

  Future<void> _mapNotifyDataChangedEventToState(NotifyDataChangedEvent event, Emitter<DataState<T>> emit) async {
    emit(DataLoadingState<T>());
    emit(DataLoadedState<T>(value!));
  }

  Future<T> fetchRemoteData();

  Future<T?> fetchCacheData();

  bool isLoading() {
    return state is DataLoadingState<T>;
  }
}
