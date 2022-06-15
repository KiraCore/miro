import 'package:miro/blocs/abstract_blocs/list_bloc/list_event/list_event.dart';
import 'package:miro/shared/models/list/sort_option.dart';

class SortEvent<T> extends ListEvent {
  final SortOption<T>? sortOption;

  SortEvent([this.sortOption]);

  @override
  List<Object> get props => <Object>[sortOption.hashCode];
}
