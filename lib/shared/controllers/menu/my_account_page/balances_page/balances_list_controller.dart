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
  final bool? derivedTokens;

  BalancesListController({
    required this.walletAddress,
    this.derivedTokens,
  });

  @override
  FavouritesCacheService getFavouritesCacheService() {
    return favouriteCacheService;
  }

  @override
  Future<List<BalanceModel>> getFavouritesData({bool forceRequestBool = false}) async {
    List<String> favouriteBalances = favouriteCacheService.getAll().toList();
    List<BalanceModel> balanceModelList = await queryBalanceService.getBalancesByTokenNames(walletAddress.bech32Address, favouriteBalances);
    return balanceModelList;
  }

  @override
  Future<PageData<BalanceModel>> getPageData(PaginationDetailsModel paginationDetailsModel, {bool forceRequestBool = false}) async {
    List<String> favouriteBalances = favouriteCacheService.getAll().toList();

    PageData<BalanceModel> balancesPageData = await queryBalanceService.getBalanceModelList(
      QueryBalanceReq(
          address: walletAddress.bech32Address,
          limit: paginationDetailsModel.limit,
          offset: paginationDetailsModel.offset,
          exclude: favouriteBalances,
          derived: derivedTokens,
      ),
      forceRequestBool: forceRequestBool,
    );

    if (balancesPageData.listItems.isEmpty) {
      Set<String> favouriteBalances = favouriteCacheService.getAll();
      TokenAliasModel defaultTokenAliasModel = globalLocator<NetworkModuleBloc>().state.defaultTokenAliasModel!;

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
