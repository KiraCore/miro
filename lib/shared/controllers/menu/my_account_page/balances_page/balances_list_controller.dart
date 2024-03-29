import 'package:decimal/decimal.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/controllers/i_list_controller.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/services/api_kira/query_balance_service.dart';
import 'package:miro/infra/services/cache/favourites_cache_service.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/list/pagination_details_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class BalancesListController implements IListController<BalanceModel> {
  final FavouritesCacheService favouriteCacheService = FavouritesCacheService(domainName: 'balances');
  final QueryBalanceService queryBalanceService = globalLocator<QueryBalanceService>();
  final WalletAddress walletAddress;

  BalancesListController({
    required this.walletAddress,
  });

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouriteCacheService;
  }

  @override
  Future<List<BalanceModel>> getFavouritesData({bool forceRequestBool = false}) async {
    Set<String> favouriteBalances = favouriteCacheService.getAll();
    if (favouriteBalances.isNotEmpty) {
      // TODO(dominik): implement request Balances by name
      PageData<BalanceModel> balancesPageData = await queryBalanceService.getBalanceModelList(
        QueryBalanceReq(address: walletAddress.bech32Address, offset: 0, limit: 500),
        forceRequestBool: forceRequestBool,
      );

      return balancesPageData.listItems.where((BalanceModel balanceModel) {
        return favouriteBalances.contains(balanceModel.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name);
      }).toList();
    }
    return List<BalanceModel>.empty(growable: true);
  }

  @override
  Future<PageData<BalanceModel>> getPageData(PaginationDetailsModel paginationDetailsModel, {bool forceRequestBool = false}) async {
    PageData<BalanceModel> balancesPageData = await queryBalanceService.getBalanceModelList(
      QueryBalanceReq(address: walletAddress.bech32Address, limit: paginationDetailsModel.limit, offset: paginationDetailsModel.offset),
      forceRequestBool: forceRequestBool,
    );

    if (balancesPageData.listItems.isEmpty) {
      Set<String> favouriteBalances = favouriteCacheService.getAll();
      TokenAliasModel defaultTokenAliasModel = globalLocator<NetworkModuleBloc>().tokenDefaultDenomModel.defaultTokenAliasModel!;

      BalanceModel defaultBalanceModel = BalanceModel(
        tokenAmountModel: TokenAmountModel(
          tokenAliasModel: defaultTokenAliasModel,
          defaultDenominationAmount: Decimal.fromInt(0),
        ),
        favourite: favouriteBalances.contains(defaultTokenAliasModel.defaultTokenDenominationModel.name),
      );

      return balancesPageData.copyWith(
        listItems: <BalanceModel>[defaultBalanceModel],
        lastPageBool: true,
      );
    } else {
      return balancesPageData;
    }
  }
}
