import 'package:equatable/equatable.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';

class FilterOptionModel<T extends AListItem> extends Equatable {
  final String title;
  final FilterOption<T> filterOption;

  const FilterOptionModel({
    required this.title,
    required this.filterOption,
  });

  FilterOptionModel<T> copyWith({
    String? title,
    FilterOption<T>? filterOption,
  }) {
    return FilterOptionModel<T>(
      title: title ?? this.title,
      filterOption: filterOption ?? this.filterOption,
    );
  }

  @override
  List<Object?> get props => <Object>[title, filterOption];
}
