import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
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
  Future<List<MockListItem>> getFavouritesData({bool? forceRequestBool = false}) async {
    Set<String> favouritesId = favouritesCacheService.getAll();
    return _items.where((MockListItem mockListItem) => favouritesId.contains(mockListItem.cacheId)).toList();
  }

  @override
  Future<PageData<MockListItem>> getPageData(PaginationDetailsModel paginationDetailsModel, {bool? forceRequestBool = false}) async {
    List<MockListItem> mockedList = ListUtils.getSafeSublist<MockListItem>(
      list: _items,
      start: paginationDetailsModel.offset,
      end: paginationDetailsModel.offset + paginationDetailsModel.limit,
    );

    return PageData<MockListItem>(
      listItems: mockedList,
      lastPageBool: mockedList.length < paginationDetailsModel.limit,
      blockDateTime: DateTime.parse('2021-01-01 00:00:00'),
      cacheExpirationDateTime: DateTime.parse('2021-01-01 00:00:00'),
    );
  }
}
