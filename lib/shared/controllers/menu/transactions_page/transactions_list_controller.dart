import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_blocks_transactions/request/query_block_transactions_req.dart';
import 'package:miro/infra/dto/api/query_transactions/request/query_transactions_req.dart';
import 'package:miro/infra/services/api/query_transactions_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

class TransactionsListController implements IListController<TxListItemModel> {
  final FavouritesCacheService favouritesCacheService = FavouritesCacheService(domainName: 'transactions');
  final QueryTransactionsService queryTransactionsService = globalLocator<QueryTransactionsService>();

  String? kiraAddress;
  String? blockId;
  List<TxMsgType>? typeFilters;
  DateTime? startDateTime;
  DateTime? endDateTime;

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouritesCacheService;
  }

  @override
  Future<List<TxListItemModel>> getFavouritesData({bool forceRequestBool = false}) async {
    return List<TxListItemModel>.empty();
  }

  @override
  Future<PageData<TxListItemModel>> getPageData(PaginationDetailsModel paginationDetailsModel,
      {bool forceRequestBool = false}) async {
    PageData<TxListItemModel> transactionsPageData;
    if (blockId != null) {
      transactionsPageData = await queryTransactionsService.getBlockTransactions(
        QueryBlockTransactionsReq(
          address: kiraAddress,
          blockId: blockId!,
          limit: paginationDetailsModel.limit,
          offset: paginationDetailsModel.offset,
          dateStart: startDateTime,
          dateEnd: endDateTime,
          type: typeFilters,
        ),
        forceRequestBool: forceRequestBool,
      );
    } else {
      transactionsPageData = await queryTransactionsService.getTransactionList(
        QueryTransactionsReq(
          // TODO: for all addresses
          address: kiraAddress ?? 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
          limit: paginationDetailsModel.limit,
          offset: paginationDetailsModel.offset,
          dateStart: startDateTime,
          dateEnd: endDateTime,
          type: typeFilters,
        ),
        forceRequestBool: forceRequestBool,
      );
    }
    return transactionsPageData;
  }
}
