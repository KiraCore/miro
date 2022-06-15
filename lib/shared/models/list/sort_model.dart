import 'package:miro/shared/models/list/sort_option.dart';

class SortModel<T> {
  final String name;
  final SortOption<T> sortOption;

  SortModel({
    required this.name,
    required this.sortOption,
  });
}
