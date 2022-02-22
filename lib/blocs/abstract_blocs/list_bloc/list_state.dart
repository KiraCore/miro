part of 'list_bloc.dart';

class ListState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class ListLoadingState extends ListState {}

class ListRefreshingState extends ListState {}

class ListLoadedState<T> extends ListState {
  final Set<T> listItems;
  final bool listEndStatus;

  ListLoadedState({
    required this.listItems,
    required this.listEndStatus,
  });

  @override
  List<Object?> get props => <Object?>[listItems.hashCode, listEndStatus.hashCode];
}

class ListEmptyState<T> extends ListLoadedState<T> {
  ListEmptyState({
    required Set<T> listItems,
    required bool listEndStatus,
  }) : super(listItems: listItems, listEndStatus: listEndStatus);
}

class ListSortedState<T> extends ListLoadedState<T> {
  ListSortedState({
    required Set<T> listItems,
    required bool listEndStatus,
  }) : super(listItems: listItems, listEndStatus: listEndStatus);
}

class ListFilteredState<T> extends ListLoadedState<T> {
  ListFilteredState({
    required Set<T> filteredItems,
    required bool listEndStatus,
  }) : super(listItems: filteredItems, listEndStatus: listEndStatus);
}

class ListSearchedState<T> extends ListLoadedState<T> {
  ListSearchedState({
    required Set<T> filteredItems,
    required bool listEndStatus,
  }) : super(listItems: filteredItems, listEndStatus: listEndStatus);
}

class ListErrorState extends ListState {}
