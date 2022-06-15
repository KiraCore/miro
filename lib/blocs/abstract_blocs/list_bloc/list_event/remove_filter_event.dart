import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/list_event.dart';
import 'package:miro/shared/models/list/filter_option.dart';

class RemoveFilterEvent<T> extends ListEvent {
  final FilterOption<T> filterOption;

  RemoveFilterEvent(this.filterOption);

  @override
  List<Object> get props => <Object>[filterOption.hashCode];
}
