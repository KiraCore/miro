import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/sort_options_bloc/sort_option_event.dart';
import 'package:miro/blocs/specific_blocs/lists/sort_options_bloc/sort_option_state.dart';
import 'package:miro/shared/utils/list/sort_option.dart';

class SortOptionBloc<T> extends Bloc<SortOptionEvent, SortOptionState<T>> {
  final SortOption<T> defaultSortOption;

  SortOptionBloc({
    required this.defaultSortOption,
  }) : super(SortOptionState<T>(defaultSortOption)) {
    on<ChangeSortOptionEvent<T>>(_mapChangeSortOptionEventToState);
    on<ClearSortOptionEvent<T>>(_mapClearSortOptionEventToState);
  }

  void _mapChangeSortOptionEventToState(
      ChangeSortOptionEvent<T> changeSortOptionEvent, Emitter<SortOptionState<T>> emit) {
    emit(SortOptionState<T>(changeSortOptionEvent.sortOption));
  }

  void _mapClearSortOptionEventToState(ClearSortOptionEvent<T> clearSortOptionEvent, Emitter<SortOptionState<T>> emit) {
    emit(SortOptionState<T>(defaultSortOption));
  }
}
