import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';

abstract class IListController<T extends AListItem> {
  FavouritesCacheService getFavouritesCacheService();

  Future<List<T>> getFavouritesData();

  Future<PageData<T>> getPageData(PaginationDetailsModel paginationDetailsModel);
}
