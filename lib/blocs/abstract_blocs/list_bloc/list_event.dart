part of 'list_bloc.dart';

abstract class ListEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class InitListEvent extends ListEvent {}

class RefreshListEvent extends ListEvent {}

class GoToPageEvent extends ListEvent {
  final int pageIndex;

  GoToPageEvent(this.pageIndex);
}

class SortEvent<T> extends ListEvent {
  final SortOption<T>? sortOption;

  SortEvent([this.sortOption]);

  @override
  List<Object> get props => <Object>[sortOption.hashCode];
}

class AddFilterEvent<T> extends ListEvent {
  final FilterOption<T> filterComparator;

  AddFilterEvent(this.filterComparator);
}

class RemoveFilterEvent<T> extends ListEvent {
  final FilterOption<T> filterComparator;

  RemoveFilterEvent(this.filterComparator);
}

class FilterEvent<T> extends ListEvent {
  FilterEvent();

  ListState prepareState({
    required Set<T> allListItems,
    required Set<T> itemsFromStart,
    required Set<T> pageListItems,
    required bool listEndStatus,
    required int currentPageIndex,
    required int maxPagesIndex,
  }) {
    return ListFilteredState<T>(
      allListItems: allListItems,
      itemsFromStart: itemsFromStart,
      pageListItems: pageListItems,
      listEndStatus: listEndStatus,
      currentPageIndex: currentPageIndex,
      maxPagesIndex: maxPagesIndex,
    );
  }

  @override
  List<Object> get props => <Object>[];
}

class SearchEvent<T> extends FilterEvent<T> {
  final bool Function(T item) searchComparator;

  SearchEvent(this.searchComparator) : super();

  @override
  ListState prepareState({
    required Set<T> allListItems,
    required Set<T> itemsFromStart,
    required Set<T> pageListItems,
    required bool listEndStatus,
    required int currentPageIndex,
    required int maxPagesIndex,
  }) {
    return ListSearchedState<T>(
      allListItems: allListItems,
      itemsFromStart: itemsFromStart,
      pageListItems: pageListItems,
      listEndStatus: listEndStatus,
      currentPageIndex: currentPageIndex,
      maxPagesIndex: maxPagesIndex,
    );
  }

  @override
  List<Object> get props => <Object>[searchComparator.hashCode];
}
