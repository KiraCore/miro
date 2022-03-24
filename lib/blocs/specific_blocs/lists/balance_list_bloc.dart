import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/infra/cache/favourite_cache.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/models/list/sort_option.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/pages/balances_comparator.dart';

class BalanceListBloc extends ListBloc<Balance> {
  static String favouriteCacheWorkspace = 'favourite_currencies';

  final QueryBalanceService queryBalanceService;
  final WalletProvider walletProvider;

  BalanceListBloc({
    required NetworkProvider networkProvider,
    required this.queryBalanceService,
    required this.walletProvider,
  }) : super(networkProvider: networkProvider) {
    walletProvider.addListener(() => add(RefreshListEvent()));
  }

  BalanceListBloc.init({
    required NetworkProvider networkProvider,
    required this.queryBalanceService,
    required this.walletProvider,
  }) : super.init(networkProvider: networkProvider) {
    walletProvider.addListener(() => add(RefreshListEvent()));
  }

  @override
  SortOption<Balance> get defaultSortOption => BalancesComparator().getSortOption(BalanceSortOption.name);

  @override
  Future<Set<Balance>> downloadListData() async {
    if (!walletProvider.isLoggedIn) {
      AppLogger().log(message: 'User not logged in');
      return <Balance>{};
    }
    List<Balance> remoteBalances = await _fetchBalances();

    Set<Balance> finalBalances = <Balance>{
      ...remoteBalances,
      // Mock data
      // TODO(dominik): Its only dev mock. Remove it before merge
      ...const <Balance>[
        Balance(amount: '666999', denom: 'ETH'),
        Balance(amount: '1234', denom: 'BTC'),
        Balance(amount: '0.235', denom: 'USDT'),
        Balance(amount: '0.9999', denom: 'ADA'),
        Balance(amount: '0.00001', denom: 'DOT'),
        Balance(amount: '0.000012341', denom: 'XRP'),
        Balance(amount: '0.000342101', denom: 'UNI'),
        Balance(amount: '1', denom: 'XLM'),
        Balance(amount: '1.55', denom: 'XCH'),
        Balance(amount: '1.124334', denom: 'BNB'),
        Balance(amount: '8374928743', denom: 'SOL'),
        Balance(amount: '98236', denom: 'CRO'),
        Balance(amount: '12344', denom: 'LTC'),
        Balance(amount: '123123.12310', denom: 'BCH'),
        Balance(amount: '123123.12341', denom: 'AAB'),
        Balance(amount: '123123.12343', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
        Balance(amount: '123123.12344', denom: 'AAE'),
        Balance(amount: '123123.12345', denom: 'AAF'),
        Balance(amount: '123123.12346', denom: 'AAG'),
        Balance(amount: '123123.12347', denom: 'AAH'),
        Balance(amount: '123123.12348', denom: 'AAI'),
        Balance(amount: '123123.12349', denom: 'AAJ'),
      ],
      // TODO(dominik): End of mock
    };
    return finalBalances;
  }

  @override
  Set<Balance> getSortedList(Set<Balance> listItems) {
    List<Balance> favouriteBalance = listItems.where(_favouriteFilter).toList();
    Set<Balance> sortedFavourites = sortList(favouriteBalance.toSet());
    Set<Balance> sortedList = sortList(listItems.where((Balance e) => !favouriteBalance.contains(e)).toSet());
    return <Balance>{
      ...sortedFavourites,
      ...sortedList,
    };
  }

  Future<List<Balance>> _fetchBalances() async {
    try {
      QueryBalanceResp queryBalanceResp = (await queryBalanceService.getMyAccountBalance())!;
      return queryBalanceResp.balances;
    } catch (e) {
      AppLogger().log(message: 'Network error while fetching Balances: $e');
      return List<Balance>.empty();
    }
  }

  bool _favouriteFilter(Balance balance) {
    FavouriteCache favouriteCache = FavouriteCache(boxName: favouriteCacheWorkspace);
    return favouriteCache.get(id: balance.denom);
  }
}
