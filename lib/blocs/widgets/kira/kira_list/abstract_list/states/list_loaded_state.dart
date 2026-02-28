import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/a_list_state.dart';

class ListLoadedState<T> extends AListState {
  final bool lastPage;
  final List<T> listItems;
  final DateTime blockDateTime;
  final DateTime cacheExpirationDateTime;

  ListLoadedState({
    required this.listItems,
    required this.lastPage,
    required this.blockDateTime,
    DateTime? cacheExpirationDateTime,
  }) : // TODO: #29
        cacheExpirationDateTime = cacheExpirationDateTime ?? DateTime.now().add(const Duration(seconds: 30));

  @override
  List<Object?> get props => <Object?>[listItems, lastPage, blockDateTime, cacheExpirationDateTime];
}
