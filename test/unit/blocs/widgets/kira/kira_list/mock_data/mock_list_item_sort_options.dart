import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';

import 'mock_list_item.dart';

class MockListItemSortOptions {
  static SortOption<MockListItem> get sortById {
    return SortOption<MockListItem>.asc(
      id: 'id',
      comparator: (MockListItem a, MockListItem b) => a.id.compareTo(b.id),
    );
  }

  static SortOption<MockListItem> get sortByName {
    return SortOption<MockListItem>.asc(
      id: 'name',
      comparator: (MockListItem a, MockListItem b) => a.name.compareTo(b.name),
    );
  }

  static SortOption<MockListItem> get sortByStatus {
    return SortOption<MockListItem>.asc(
      id: 'status',
      comparator: (MockListItem a, MockListItem b) => a.status.toString().compareTo(b.status.toString()),
    );
  }
}
