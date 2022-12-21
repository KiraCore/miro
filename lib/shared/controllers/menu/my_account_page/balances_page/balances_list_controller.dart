import 'package:miro/blocs/abstract_blocs/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/favourite_cache.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/services/api_kira/query_balance_service.dart';
import 'package:miro/shared/models/balances/balance_model.dart';

class BalancesListController implements IListController<BalanceModel> {
  final FavouriteCache favouriteCache = FavouriteCache(key: 'balances');
  final QueryBalanceService queryBalanceService = globalLocator<QueryBalanceService>();
  final String address;

  BalancesListController({
    required this.address,
  });

  @override
  FavouriteCache getFavouriteCache() {
    return favouriteCache;
  }

  @override
  Future<List<BalanceModel>> getFavouritesData() async {
    Set<String> favouriteBalances = favouriteCache.getAll();
    if (favouriteBalances.isNotEmpty) {
      // TODO(dominik): implement request Balances by name
      List<BalanceModel> allBalancesList = await queryBalanceService.getBalanceModelList(
        QueryBalanceReq(
          address: address,
          offset: 0,
          limit: 500,
        ),
      );
      return allBalancesList.where((BalanceModel balanceModel) {
        return favouriteBalances.contains(balanceModel.tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name);
      }).toList();
    }
    return List<BalanceModel>.empty(growable: true);
  }

  @override
  Future<List<BalanceModel>> getPageData(int pageIndex, int offset, int limit) async {
    List<BalanceModel> balancesList = await queryBalanceService.getBalanceModelList(
      QueryBalanceReq(
        address: address,
        offset: offset,
        limit: limit,
      ),
    );
    return balancesList;
  }
}
