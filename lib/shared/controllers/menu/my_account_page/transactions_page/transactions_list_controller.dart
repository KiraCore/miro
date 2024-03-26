import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_transactions/request/query_transactions_req.dart';
import 'package:miro/infra/services/api/query_transactions_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/list/tx_sort_type.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class TransactionsListController implements IListController<TxListItemModel> {
  final FavouritesCacheService favouriteCacheService = FavouritesCacheService(domainName: 'transactions');
  final QueryTransactionsService queryTransactionsService = globalLocator<QueryTransactionsService>();
  final WalletAddress walletAddress;

  List<TxDirectionType>? directionFilters;
  List<TxStatusType>? statusFilters;
  DateTime? startDateTime;
  DateTime? endDateTime;

  TransactionsListController({
    required this.walletAddress,
  });

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouriteCacheService;
  }

  @override
  Future<List<TxListItemModel>> getFavouritesData({bool forceRequestBool = false}) async {
    return List<TxListItemModel>.empty();
  }

  @override
  Future<PageData<TxListItemModel>> getPageData(PaginationDetailsModel paginationDetailsModel, {bool forceRequestBool = false}) async {
    PageData<TxListItemModel> transactionsPageData = await queryTransactionsService.getTransactionList(
      QueryTransactionsReq(
        address: walletAddress.bech32Address,
        limit: paginationDetailsModel.limit,
        offset: paginationDetailsModel.offset,
        sort: TxSortType.dateDESC,
        dateStart: startDateTime,
        dateEnd: endDateTime,
        status: statusFilters,
        direction: directionFilters,
      ),
      forceRequestBool: forceRequestBool,
    );
    return transactionsPageData;
  }
}
