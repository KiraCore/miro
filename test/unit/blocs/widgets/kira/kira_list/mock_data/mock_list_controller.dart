import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/utils/list_utils.dart';

import 'mock_list_item.dart';

class MockListController extends IListController<MockListItem> {
  final FavouritesCacheService favouritesCacheService = FavouritesCacheService(domainName: 'test_favourites');

  final List<MockListItem> _items = <MockListItem>[
    MockListItem(id: 1, name: 'apple', status: 'active'),
    MockListItem(id: 2, name: 'banana', status: 'active'),
    MockListItem(id: 3, name: 'coconut', status: 'paused'),
  ];

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouritesCacheService;
  }

  @override
  Future<List<MockListItem>> getFavouritesData() async {
    Set<String> favouritesId = favouritesCacheService.getAll();
    return _items.where((MockListItem mockListItem) => favouritesId.contains(mockListItem.cacheId)).toList();
  }

  @override
  Future<List<MockListItem>> getPageData(int pageIndex, int offset, int limit) async {
    return ListUtils.getSafeSublist<MockListItem>(list: _items, start: offset, end: offset + limit);
  }
}
