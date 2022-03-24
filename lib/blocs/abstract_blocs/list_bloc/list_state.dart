part of 'list_bloc.dart';

class ListState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class ListLoadingState extends ListState {}

class ListRefreshingState extends ListState {}

class ListLoadedState<T> extends ListState {
  final Set<T> allListItems;
  final Set<T> itemsFromStart;
  final Set<T> pageListItems;
  final bool listEndStatus;
  final int currentPageIndex;
  final int maxPagesIndex;

  ListLoadedState({
    required this.allListItems,
    required this.itemsFromStart,
    required this.pageListItems,
    required this.listEndStatus,
    required this.currentPageIndex,
    required this.maxPagesIndex,
  });

  @override
  List<Object?> get props => <Object?>[
        allListItems,
        listEndStatus,
        itemsFromStart,
        pageListItems,
        currentPageIndex,
        maxPagesIndex,
      ];

  @override
  String toString() {
    return 'ListLoadedState{allListItems: $allListItems,\n'
        'itemsFromStart: $itemsFromStart,\n '
        'pageListItems: $pageListItems,\n '
        'listEndStatus: $listEndStatus,\n '
        'currentPageIndex: $currentPageIndex,\n'
        'maxPagesIndex: $maxPagesIndex}';
  }
}

class ListEmptyState<T> extends ListLoadedState<T> {
  ListEmptyState({
    required Set<T> allListItems,
    required Set<T> itemsFromStart,
    required Set<T> pageListItems,
    required bool listEndStatus,
    required int currentPageIndex,
    required int maxPagesIndex,
  }) : super(
          allListItems: allListItems,
          itemsFromStart: itemsFromStart,
          pageListItems: pageListItems,
          listEndStatus: listEndStatus,
          currentPageIndex: currentPageIndex,
          maxPagesIndex: maxPagesIndex,
        );
}

class ListSortedState<T> extends ListLoadedState<T> {
  ListSortedState({
    required Set<T> allListItems,
    required Set<T> itemsFromStart,
    required Set<T> pageListItems,
    required bool listEndStatus,
    required int currentPageIndex,
    required int maxPagesIndex,
  }) : super(
          allListItems: allListItems,
          itemsFromStart: itemsFromStart,
          pageListItems: pageListItems,
          listEndStatus: listEndStatus,
          currentPageIndex: currentPageIndex,
          maxPagesIndex: maxPagesIndex,
        );
}

class ListFilteredState<T> extends ListLoadedState<T> {
  ListFilteredState({
    required Set<T> allListItems,
    required Set<T> itemsFromStart,
    required Set<T> pageListItems,
    required bool listEndStatus,
    required int currentPageIndex,
    required int maxPagesIndex,
  }) : super(
          allListItems: allListItems,
          itemsFromStart: itemsFromStart,
          pageListItems: pageListItems,
          listEndStatus: listEndStatus,
          currentPageIndex: currentPageIndex,
          maxPagesIndex: maxPagesIndex,
        );
}

class ListSearchedState<T> extends ListLoadedState<T> {
  ListSearchedState({
    required Set<T> allListItems,
    required Set<T> itemsFromStart,
    required Set<T> pageListItems,
    required bool listEndStatus,
    required int currentPageIndex,
    required int maxPagesIndex,
  }) : super(
          allListItems: allListItems,
          itemsFromStart: itemsFromStart,
          pageListItems: pageListItems,
          listEndStatus: listEndStatus,
          currentPageIndex: currentPageIndex,
          maxPagesIndex: maxPagesIndex,
        );
}

class ListErrorState extends ListState {}
