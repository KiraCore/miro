import 'package:miro/blocs/specific_blocs/list/sort/models/sort_option.dart';

import 'test_list_item.dart';

class TestListItemSortOptions {
  static SortOption<TestListItem> get sortById {
    return SortOption<TestListItem>.asc(
      id: 'id',
      comparator: (TestListItem a, TestListItem b) => a.id.compareTo(b.id),
    );
  }

  static SortOption<TestListItem> get sortByName {
    return SortOption<TestListItem>.asc(
      id: 'name',
      comparator: (TestListItem a, TestListItem b) => a.name.compareTo(b.name),
    );
  }

  static SortOption<TestListItem> get sortByStatus {
    return SortOption<TestListItem>.asc(
      id: 'status',
      comparator: (TestListItem a, TestListItem b) => a.status.toString().compareTo(b.status.toString()),
    );
  }
}
