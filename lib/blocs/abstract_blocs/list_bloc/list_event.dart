part of 'list_bloc.dart';

class ListEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class InitListEvent extends ListEvent {}

class RefreshListEvent extends ListEvent {}

class GetNextPageEvent extends ListEvent {}

class SortEvent<T> extends ListEvent {
  final SortOption<T>? sortOption;

  SortEvent([this.sortOption]);

  @override
  List<Object> get props => <Object>[sortOption.hashCode];
}

class FilterEvent<T> extends ListEvent {
  final bool Function(T item) filterComparator;

  FilterEvent(this.filterComparator);

  ListState prepareState({
    required Set<T> filteredItems,
    required bool listEndStatus,
  }) {
    return ListFilteredState<T>(filteredItems: filteredItems, listEndStatus: listEndStatus);
  }

  @override
  List<Object> get props => <Object>[filterComparator.hashCode];
}

class SearchEvent<T> extends FilterEvent<T> {
  final bool Function(T item) searchComparator;

  SearchEvent(this.searchComparator) : super(searchComparator);

  @override
  ListState prepareState({
    required Set<T> filteredItems,
    required bool listEndStatus,
  }) {
    return ListSearchedState<T>(filteredItems: filteredItems, listEndStatus: listEndStatus);
  }

  @override
  List<Object> get props => <Object>[searchComparator.hashCode];
}
