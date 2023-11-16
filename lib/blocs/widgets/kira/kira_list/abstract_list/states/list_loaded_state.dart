import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_state.dart';

class ListLoadedState<T> extends AListState {
  final bool lastPage;
  final List<T> listItems;
  final DateTime blockDateTime;
  final DateTime cacheExpirationDateTime;

  const ListLoadedState({
    required this.listItems,
    required this.lastPage,
    required this.blockDateTime,
    required this.cacheExpirationDateTime,
  });

  @override
  List<Object?> get props => <Object?>[listItems, lastPage, blockDateTime, cacheExpirationDateTime];
}
