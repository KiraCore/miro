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

class TransactionsListController implements IListController<TxListItemModel> {
  final FavouritesCacheService favouriteCacheService = FavouritesCacheService(domainName: 'transactions');
  final QueryTransactionsService queryTransactionsService = globalLocator<QueryTransactionsService>();
  final String address;

  List<TxDirectionType>? directionFilters;
  List<TxStatusType>? statusFilters;
  DateTime? startDateTime;
  DateTime? endDateTime;

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
  Future<PageData<TxListItemModel>> getPageData(PaginationDetailsModel paginationDetailsModel) async {
    PageData<TxListItemModel> transactionsPageData = await queryTransactionsService.getTransactionList(
      QueryTransactionsReq(
        address: address,
        limit: paginationDetailsModel.limit,
        offset: paginationDetailsModel.offset,
        sort: TxSortType.dateDESC,
        dateStart: startDateTime,
        dateEnd: endDateTime,
        status: statusFilters,
        direction: directionFilters,
      ),
    );
    return transactionsPageData;
  }
}
