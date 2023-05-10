import 'package:equatable/equatable.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';

abstract class AFiltersState<T extends AListItem> extends Equatable {
  final List<FilterOption<T>> activeFilters;

  const AFiltersState({
    required this.activeFilters,
  });

  @override
  List<Object?> get props => <Object>[activeFilters];
}
