import 'package:miro/blocs/abstract_blocs/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/infra/cache/favourite_cache.dart';
import 'package:miro/shared/utils/list_utils.dart';

import 'mock_list_item.dart';

class MockListController extends IListController<MockListItem> {
  final FavouriteCache favouriteCache = FavouriteCache(key: 'test_favourites');

  final List<MockListItem> _items = <MockListItem>[
    MockListItem(id: 1, name: 'apple', status: 'active'),
    MockListItem(id: 2, name: 'banana', status: 'active'),
    MockListItem(id: 3, name: 'coconut', status: 'paused'),
  ];

  @override
  FavouriteCache getFavouriteCache() {
    return favouriteCache;
  }

  @override
  Future<List<MockListItem>> getFavouritesData() async {
    Set<String> favouritesId = favouriteCache.getAll();
    return _items.where((MockListItem mockListItem) => favouritesId.contains(mockListItem.cacheId)).toList();
  }

  @override
  Future<List<MockListItem>> getPageData(int pageIndex, int offset, int limit) async {
    return ListUtils.getSafeSublist<MockListItem>(list: _items, start: offset, end: offset + limit);
  }
}
