import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_transactions/request/query_transactions_req.dart';
import 'package:miro/infra/services/api/query_transactions_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/shared/models/transactions/list/tx_sort_type.dart';

class TransactionsListController implements IListController<TxListItemModel> {
  final FavouritesCacheService favouriteCacheService = FavouritesCacheService(domainName: 'transactions');
  final QueryTransactionsService queryTransactionsService = globalLocator<QueryTransactionsService>();
  final String address;

  TransactionsListController({
    required this.address,
  });

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouriteCacheService;
  }

  @override
  Future<List<TxListItemModel>> getFavouritesData() async {
    return List<TxListItemModel>.empty();
  }

  @override
  Future<List<TxListItemModel>> getPageData(int pageIndex, int offset, int limit) async {
    List<TxListItemModel> transactionsList = await queryTransactionsService.getTransactionList(
      QueryTransactionsReq(
        address: address,
        offset: offset,
        limit: limit,
        sort: TxSortType.dateDESC,
      ),
    );
    return transactionsList;
  }
}
