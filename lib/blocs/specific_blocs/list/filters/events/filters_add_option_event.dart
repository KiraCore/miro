import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/filters/a_filters_event.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';

class FiltersAddOptionEvent<T extends AListItem> extends AFiltersEvent {
  final FilterOption<T> filterOption;

  const FiltersAddOptionEvent(this.filterOption);

  @override
  List<Object> get props => <Object>[filterOption.hashCode];
}
