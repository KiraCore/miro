part of 'data_bloc.dart';

class DataState<T> extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class DataEmptyState<T> extends DataState<T> {}

class DataLoadingState<T> extends DataState<T> {}

class DataLoadedState<T extends Object> extends DataState<T> {
  final T value;

  DataLoadedState(this.value);

  @override
  List<Object> get props => <Object>[value.hashCode];
}

class DataRefreshingState<T> extends DataState<T> {}

class DataErrorState<T> extends DataState<T> {}
