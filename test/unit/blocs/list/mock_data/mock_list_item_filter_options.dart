import 'package:miro/blocs/specific_blocs/list/filters/models/filter_option.dart';

import 'mock_list_item.dart';

class MockListItemFilterOptions {
  static FilterOption<MockListItem> filterByActive = FilterOption<MockListItem>(
    id: 'active',
    filterComparator: (MockListItem a) => a.status == 'active',
  );

  static FilterOption<MockListItem> filterByPaused = FilterOption<MockListItem>(
    id: 'paused',
    filterComparator: (MockListItem a) => a.status == 'paused',
  );

  static FilterComparator<MockListItem> search(String searchText) {
    return (MockListItem item) {
      bool idMatch = item.id.toString().contains(searchText.toLowerCase());
      bool nameMatch = item.name.toLowerCase().contains(searchText.toLowerCase());
      bool statusMatch = item.status.toLowerCase().contains(searchText.toLowerCase());
      return idMatch || nameMatch || statusMatch;
    };
  }
}
