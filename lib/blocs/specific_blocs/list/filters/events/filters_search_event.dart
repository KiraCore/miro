import 'package:miro/blocs/specific_blocs/list/filters/a_filters_event.dart';

class FiltersSearchEvent<T> extends AFiltersEvent {
  final String searchText;

  const FiltersSearchEvent(this.searchText);

  @override
  List<Object> get props => <Object>[searchText];
}
