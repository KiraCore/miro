import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';

import 'test_list_item.dart';

class TestListItemFilterOptions {
  static FilterOption<TestListItem> filterByActive = FilterOption<TestListItem>(
    id: 'active',
    filterComparator: (TestListItem a) => a.status == 'active',
  );

  static FilterOption<TestListItem> filterByPaused = FilterOption<TestListItem>(
    id: 'paused',
    filterComparator: (TestListItem a) => a.status == 'paused',
  );

  static FilterComparator<TestListItem> search(String searchText) {
    return (TestListItem item) {
      bool idMatch = item.id.toString().contains(searchText.toLowerCase());
      bool nameMatch = item.name.toLowerCase().contains(searchText.toLowerCase());
      bool statusMatch = item.status.toLowerCase().contains(searchText.toLowerCase());
      return idMatch || nameMatch || statusMatch;
    };
  }
}
