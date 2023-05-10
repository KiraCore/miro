import 'package:miro/blocs/widgets/kira/kira_list/filters/a_filters_event.dart';

class FiltersSearchEvent<T> extends AFiltersEvent {
  final String searchText;

  const FiltersSearchEvent(this.searchText);

  @override
  List<Object> get props => <Object>[searchText];
}
