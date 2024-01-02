import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_blocks/request/query_blocks_req.dart';
import 'package:miro/infra/services/api/query_transactions_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/blocks/block_model.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';

class BlocksListController implements IListController<BlockModel> {
  final FavouritesCacheService favouritesCacheService = FavouritesCacheService(domainName: 'blocks');
  final QueryTransactionsService queryTransactionsService = globalLocator<QueryTransactionsService>();

  DateTime? startDateTime;
  DateTime? endDateTime;

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouritesCacheService;
  }

  @override
  Future<List<BlockModel>> getFavouritesData({bool? forceRequestBool}) async {
    return <BlockModel>[];
  }

  @override
  Future<PageData<BlockModel>> getPageData(
    PaginationDetailsModel paginationDetailsModel, {
    bool forceRequestBool = false,
  }) async {
    PageData<BlockModel> blocksPageData = await queryTransactionsService.getBlocks(
      QueryBlocksReq(
        limit: paginationDetailsModel.limit,
        offset: paginationDetailsModel.offset,
        dateStart: startDateTime,
        dateEnd: endDateTime,
      ),
      forceRequestBool: forceRequestBool,
    );
    return blocksPageData;

    // List<BlockModel> list = ListUtils.getSafeSublist(
    //     list: blocksModelList, start: paginationDetailsModel.offset, end: paginationDetailsModel.limit);
    // return PageData<BlockModel>(
    //   listItems: list,
    //   lastPageBool: list.length < paginationDetailsModel.limit,
    //   blockDateTime: DateTime.now(),
    //   cacheExpirationDateTime: DateTime.now(),
    // );
  }

}
