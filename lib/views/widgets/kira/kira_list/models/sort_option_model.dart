import 'package:equatable/equatable.dart';
import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';

class SortOptionModel<T extends AListItem> extends Equatable {
  final String title;
  final SortOption<T> sortOption;

  const SortOptionModel({
    required this.title,
    required this.sortOption,
  });

  SortOptionModel<T> copyWith({
    String? title,
    SortOption<T>? sortOption,
  }) {
    return SortOptionModel<T>(
      title: title ?? this.title,
      sortOption: sortOption ?? this.sortOption,
    );
  }

  @override
  List<Object?> get props => <Object>[title, sortOption];
}
