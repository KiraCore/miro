import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/list_event.dart';

class SearchEvent<T> extends ListEvent {
  final String searchText;

  SearchEvent(this.searchText);

  @override
  List<Object> get props => <Object>[searchText];
}
