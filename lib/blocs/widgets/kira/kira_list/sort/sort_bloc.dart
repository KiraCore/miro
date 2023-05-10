import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/a_sort_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/events/sort_change_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/events/sort_clear_event.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';
import 'package:miro/blocs/widgets/kira/kira_list/sort/sort_state.dart';

class SortBloc<T extends AListItem> extends Bloc<ASortEvent, SortState<T>> {
  final SortOption<T> defaultSortOption;

  SortBloc({
    required this.defaultSortOption,
  }) : super(SortState<T>(defaultSortOption)) {
    on<SortChangeEvent<T>>(_mapSortChangeEventToState);
    on<SortClearEvent>(_mapSortClearEventToState);
  }

  void _mapSortChangeEventToState(SortChangeEvent<T> sortChangeEvent, Emitter<SortState<T>> emit) {
    emit(SortState<T>(sortChangeEvent.sortOption));
  }

  void _mapSortClearEventToState(SortClearEvent sortClearEvent, Emitter<SortState<T>> emit) {
    emit(SortState<T>(defaultSortOption));
  }
}
