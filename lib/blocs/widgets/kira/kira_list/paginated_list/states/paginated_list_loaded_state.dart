import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/states/list_loaded_state.dart';

class PaginatedListLoadedState<T> extends ListLoadedState<T> {
  final int pageIndex;

  const PaginatedListLoadedState({
    required this.pageIndex,
    required bool lastPageBool,
    required List<T> listItems,
    required DateTime blockDateTime,
    required DateTime cacheExpirationDateTime,
  }) : super(
          lastPage: lastPageBool,
          listItems: listItems,
          blockDateTime: blockDateTime,
          cacheExpirationDateTime: cacheExpirationDateTime,
        );

  @override
  List<Object?> get props => <Object?>[pageIndex, lastPage, listItems, blockDateTime, cacheExpirationDateTime];
}
