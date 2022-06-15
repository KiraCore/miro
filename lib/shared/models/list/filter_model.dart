import 'package:miro/shared/models/list/filter_option.dart';

class FilterModel<T> {
  final String name;
  final FilterOption<T> filterOption;

  FilterModel({
    required this.name,
    required this.filterOption,
  });
}
