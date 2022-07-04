import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/list_event.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_state/list_state.dart';
import 'package:miro/blocs/specific_blocs/lists/filter_options_bloc/filter_options_event.dart';
import 'package:miro/blocs/specific_blocs/lists/filter_options_bloc/filter_options_state.dart';
import 'package:miro/shared/utils/list/filter_mode.dart';
import 'package:miro/shared/utils/list/filter_option.dart';
import 'package:miro/shared/utils/list/search_option.dart';

class FilterOptionsBloc<T> extends Bloc<FilterOptionsEvent, FilterOptionsState<T>> {
  final Bloc<ListEvent, ListState> sourceListBloc;
  final SearchComparator<T> searchComparator;

  FilterOptionsBloc({
    required this.sourceListBloc,
    required this.searchComparator,
  }) : super(EmptyFiltersState<T>()) {
    on<SearchEvent<T>>(_mapSearchEventToState);
    on<AddFilterEvent<T>>(_mapAddFilterEventToState);
    on<RemoveFilterEvent<T>>(_mapRemoveFilterEventToState);
  }

  void _mapSearchEventToState(SearchEvent<T> searchEvent, Emitter<FilterOptionsState<T>> emit) {
    List<FilterOption<T>> filterOptions = state.activeFilters..removeWhere((FilterOption<T> e) => e is SearchOption);
    if (searchEvent.searchText.isEmpty) {
      filterOptions.removeWhere((FilterOption<T> e) => e is SearchOption);
    } else {
      filterOptions.add(SearchOption<T>(searchComparator(searchEvent.searchText)));
    }
    _notifyFilterUpdated(filterOptions, emit);
  }

  void _mapAddFilterEventToState(AddFilterEvent<T> addFilterEvent, Emitter<FilterOptionsState<T>> emit) {
    List<FilterOption<T>> filterOptions = state.activeFilters..add(addFilterEvent.filterOption);
    _notifyFilterUpdated(filterOptions, emit);
  }

  void _mapRemoveFilterEventToState(RemoveFilterEvent<T> removeFilterEvent, Emitter<FilterOptionsState<T>> emit) {
    List<FilterOption<T>> filterOptions = state.activeFilters..remove(removeFilterEvent.filterOption);
    _notifyFilterUpdated(filterOptions, emit);
  }

  void _notifyFilterUpdated(List<FilterOption<T>> filterOptions, Emitter<FilterOptionsState<T>> emit) {
    FilterComparator<T> filterComparator = _generateFilterComparator(filterOptions);

    emit(filterOptions.isEmpty
        ? FiltersActiveState<T>(activeFilters: filterOptions, filterComparator: filterComparator)
        : EmptyFiltersState<T>());
  }

  FilterComparator<T> _generateFilterComparator(List<FilterOption<T>> filterOptions) {
    List<FilterOption<T>> activeAndFilters = filterOptions.where((FilterOption<T> e) {
      return e.filterMode == FilterMode.and;
    }).toList();

    List<FilterOption<T>> activeOrFilters = filterOptions.where((FilterOption<T> e) {
      return e.filterMode == FilterMode.or;
    }).toList();

    return (T item) {
      bool matchAllAndFilters = _hasAndFilterMatch(activeAndFilters, item);
      bool matchAnyOrFilters = _hasOrFilterMatch(activeOrFilters, item, activeOrFilters.isEmpty);

      return matchAllAndFilters && matchAnyOrFilters;
    };
  }

  bool _hasAndFilterMatch(List<FilterOption<T>> filters, T item) {
    bool hasMatch = true;
    for (FilterOption<T> filterOption in filters) {
      if (!filterOption.hasMatch(item)) {
        hasMatch = false;
      }
    }
    return hasMatch;
  }

  bool _hasOrFilterMatch(List<FilterOption<T>> filters, T item, bool initialValue) {
    bool hasMatch = initialValue;
    for (FilterOption<T> filterOption in filters) {
      if (filterOption.hasMatch(item)) {
        hasMatch = true;
      }
    }
    return hasMatch;
  }
}
