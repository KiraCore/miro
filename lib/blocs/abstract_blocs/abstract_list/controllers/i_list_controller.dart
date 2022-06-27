import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/infra/cache/favourite_cache.dart';

abstract class IListController<T extends AListItem> {
  FavouriteCache getFavouriteCache();

  Future<List<T>> getFavouritesData();

  Future<List<T>> getPageData(int pageIndex, int offset, int limit);
}
