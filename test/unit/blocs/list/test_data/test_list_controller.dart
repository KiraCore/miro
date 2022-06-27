import 'package:miro/blocs/abstract_blocs/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/infra/cache/favourite_cache.dart';
import 'package:miro/shared/utils/list_utils.dart';

import 'test_list_item.dart';

class TestListController extends IListController<TestListItem> {
  final FavouriteCache favouriteCache = FavouriteCache(key: 'test_favourites');

  final List<TestListItem> _items = <TestListItem>[
    TestListItem(id: 1, name: 'apple', status: 'active'),
    TestListItem(id: 2, name: 'banana', status: 'active'),
    TestListItem(id: 3, name: 'coconut', status: 'paused'),
  ];

  @override
  FavouriteCache getFavouriteCache() {
    return favouriteCache;
  }

  @override
  Future<List<TestListItem>> getFavouritesData() async {
    Set<String> favouritesId = favouriteCache.getAll();
    return _items.where((TestListItem testListItem) => favouritesId.contains(testListItem.cacheId)).toList();
  }

  @override
  Future<List<TestListItem>> getPageData(int pageIndex, int offset, int limit) async {
    return ListUtils.getSafeSublist<TestListItem>(list: _items, start: offset, end: offset + limit);
  }
}
