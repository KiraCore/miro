import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/infra/cache/favourite_cache.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/pages/balances_comparator.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option.dart';

class BalanceListBloc extends ListBloc<Balance> {
  static String favouriteCacheWorkspace = 'favourite_currencies';

  static List<SortOption<Balance>> sortOptions = const <SortOption<Balance>>[
    SortOption<Balance>(
      name: 'Name',
      comparator: BalancesComparator.sortByName,
    ),
    SortOption<Balance>(
      name: 'Amount',
      comparator: BalancesComparator.sortByAmount,
    ),
  ];

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
  SortOption<Balance> get defaultSortOption => sortOptions[0];

  @override
  Future<Set<Balance>> fetchPageData(int pageIndex) async {
    if (pageIndex == 0) {
      List<Balance> allBalances = await _fetchAllBalances();
      allListItems = getSortedList(allBalances.toSet());
    }

    await Future<void>.delayed(const Duration(seconds: 1));
    return _splitToCurrentPageData(allListItems.toList(), pageIndex);
  }

  Set<Balance> _splitToCurrentPageData(List<Balance> fullBalancesList, int pageIndex) {
    if ((pageIndex + 1) * ListBloc.pageSize < fullBalancesList.length) {
      return fullBalancesList.sublist(pageIndex * ListBloc.pageSize, (pageIndex + 1) * ListBloc.pageSize).toSet();
    }
    return fullBalancesList.sublist(pageIndex * ListBloc.pageSize, fullBalancesList.length).toSet();
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

  Future<List<Balance>> _fetchAllBalances() async {
    if (!walletProvider.isLoggedIn) {
      return List<Balance>.empty(growable: true);
    }
    QueryBalanceResp? queryBalanceResp;
    try {
      queryBalanceResp = await queryBalanceService.getMyAccountBalance();
    } catch (e) {
      AppLogger().log(message: 'Request error $e');
    }
    if (queryBalanceResp == null) {
      return List<Balance>.empty(growable: true);
    }

    List<Balance> finalBalances = <Balance>[
      ...queryBalanceResp.balances,
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
        Balance(amount: '123123.12344', denom: 'BCH'),
        Balance(amount: '123123.12344', denom: 'BCH'),
        Balance(amount: '123123.12344', denom: 'AAB'),
        Balance(amount: '123123.12344', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
        Balance(amount: '123123.12344', denom: 'AAE'),
        Balance(amount: '123123.12344', denom: 'AAF'),
        Balance(amount: '123123.12344', denom: 'AAG'),
        Balance(amount: '123123.12344', denom: 'AAH'),
        Balance(amount: '123123.12344', denom: 'AAI'),
        Balance(amount: '123123.12344', denom: 'AAJ'),
      ],
      // TODO(dominik): End of mock
    ];
    return finalBalances;
  }

  bool _favouriteFilter(Balance balance) {
    FavouriteCache favouriteCache = FavouriteCache(workspaceName: favouriteCacheWorkspace);
    return favouriteCache.get(id: balance.denom);
  }
}
