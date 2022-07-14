import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/filters/a_filters_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/a_filters_state.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_add_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_remove_option_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/events/filters_search_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_mode.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/search_option.dart';
import 'package:miro/blocs/specific_blocs/list/filters/states/filters_active_state.dart';
import 'package:miro/blocs/specific_blocs/list/filters/states/filters_empty_state.dart';

typedef SearchComparator<T> = FilterComparator<T> Function(String searchText);

class FiltersBloc<T extends AListItem> extends Bloc<AFiltersEvent, AFiltersState<T>> {
  final SearchComparator<T> searchComparator;

  FiltersBloc({
    required this.searchComparator,
  }) : super(FiltersEmptyState<T>()) {
    on<FiltersSearchEvent<T>>(_mapFiltersSearchEventToState);
    on<FiltersAddOptionEvent<T>>(_mapFiltersAddOptionEventToState);
    on<FiltersRemoveOptionEvent<T>>(_mapFiltersRemoveOptionEventToState);
  }

  void _mapFiltersSearchEventToState(FiltersSearchEvent<T> filtersSearchEvent, Emitter<AFiltersState<T>> emit) {
    List<FilterOption<T>> filterOptions = List<FilterOption<T>>.from(state.activeFilters)
      ..removeWhere((FilterOption<T> e) => e is SearchOption);
    if (filtersSearchEvent.searchText.isEmpty) {
      filterOptions.removeWhere((FilterOption<T> e) => e is SearchOption);
    } else {
      filterOptions.add(SearchOption<T>(searchComparator(filtersSearchEvent.searchText)));
    }
    _notifyFilterUpdate(filterOptions, emit);
  }

  void _mapFiltersAddOptionEventToState(
    FiltersAddOptionEvent<T> filtersAddOptionEvent,
    Emitter<AFiltersState<T>> emit,
  ) {
    List<FilterOption<T>> filterOptions = List<FilterOption<T>>.from(state.activeFilters)
      ..add(filtersAddOptionEvent.filterOption);
    _notifyFilterUpdate(filterOptions, emit);
  }

  void _mapFiltersRemoveOptionEventToState(
    FiltersRemoveOptionEvent<T> filtersRemoveOptionEvent,
    Emitter<AFiltersState<T>> emit,
  ) {
    List<FilterOption<T>> filterOptions = List<FilterOption<T>>.from(state.activeFilters)
      ..remove(filtersRemoveOptionEvent.filterOption);
    _notifyFilterUpdate(filterOptions, emit);
  }

  void _notifyFilterUpdate(List<FilterOption<T>> filterOptions, Emitter<AFiltersState<T>> emit) {
    FilterComparator<T> filterComparator = _createFilterComparator(filterOptions);

    emit(filterOptions.isNotEmpty
        ? FiltersActiveState<T>(activeFilters: filterOptions, filterComparator: filterComparator)
        : FiltersEmptyState<T>());
  }

  FilterComparator<T> _createFilterComparator(List<FilterOption<T>> filterOptions) {
    List<FilterOption<T>> activeOrFilters = filterOptions.where((FilterOption<T> e) {
      return e.filterMode == FilterMode.or;
    }).toList();

    List<FilterOption<T>> activeAndFilters = filterOptions.where((FilterOption<T> e) {
      return e.filterMode == FilterMode.and;
    }).toList();

    return (T item) {
      bool hasAnyOrFilters = _hasOrFilterMatch(activeOrFilters, item);
      bool hasAllAndFilters = _hasAndFilterMatch(activeAndFilters, item);

      return hasAnyOrFilters && hasAllAndFilters;
    };
  }

  bool _hasOrFilterMatch(List<FilterOption<T>> filters, T item) {
    if (filters.isEmpty) {
      return true;
    }
    for (FilterOption<T> filterOption in filters) {
      if (filterOption.hasMatch(item)) {
        return true;
      }
    }
    return false;
  }

  bool _hasAndFilterMatch(List<FilterOption<T>> filters, T item) {
    if (filters.isEmpty) {
      return true;
    }
    for (FilterOption<T> filterOption in filters) {
      if (!filterOption.hasMatch(item)) {
        return false;
      }
    }
    return true;
  }
}
