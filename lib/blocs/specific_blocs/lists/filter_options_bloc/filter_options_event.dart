import 'package:equatable/equatable.dart';
import 'package:miro/shared/utils/list/filter_option.dart';

class FilterOptionsEvent extends Equatable {
  @override
  List<Object?> get props => <Object>[];
}

class SearchEvent<T> extends FilterOptionsEvent {
  final String searchText;

  SearchEvent(this.searchText);

  @override
  List<Object> get props => <Object>[searchText];
}

class AddFilterEvent<T> extends FilterOptionsEvent {
  final FilterOption<T> filterOption;

  AddFilterEvent(this.filterOption);

  @override
  List<Object> get props => <Object>[filterOption.hashCode];
}

class RemoveFilterEvent<T> extends FilterOptionsEvent {
  final FilterOption<T> filterOption;

  RemoveFilterEvent(this.filterOption);

  @override
  List<Object> get props => <Object>[filterOption.hashCode];
}
