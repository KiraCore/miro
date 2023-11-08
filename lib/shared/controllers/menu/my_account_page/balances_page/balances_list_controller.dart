import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/services/api_kira/query_balance_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';

class BalancesListController implements IListController<BalanceModel> {
  final FavouritesCacheService favouriteCacheService = FavouritesCacheService(domainName: 'balances');
  final QueryBalanceService queryBalanceService = globalLocator<QueryBalanceService>();
  final String address;

  BalancesListController({
    required this.address,
  });

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouriteCacheService;
  }

  @override
  Future<List<BalanceModel>> getFavouritesData() async {
    Set<String> favouriteBalances = favouriteCacheService.getAll();
    if (favouriteBalances.isNotEmpty) {
      // TODO(dominik): implement request Balances by name
      PageData<BalanceModel> balancesPageData = await queryBalanceService.getBalanceModelList(QueryBalanceReq(
        address: address,
        offset: 0,
        limit: 500,
      ));

      return balancesPageData.listItems.where((BalanceModel balanceModel) {
        return favouriteBalances.contains(balanceModel.tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name);
      }).toList();
    }
    return List<BalanceModel>.empty(growable: true);
  }

  @override
  Future<PageData<BalanceModel>> getPageData(PaginationDetailsModel paginationDetailsModel) async {
    PageData<BalanceModel> balancesPageData = await queryBalanceService.getBalanceModelList(QueryBalanceReq(
      address: address,
      limit: paginationDetailsModel.limit,
      offset: paginationDetailsModel.offset,
    ));
    return balancesPageData;
  }
}
