import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';

abstract class IListController<T extends AListItem> {
  FavouritesCacheService getFavouritesCacheService();

  Future<List<T>> getFavouritesData();

  Future<List<T>> getPageData(int pageIndex, int offset, int limit);
}
