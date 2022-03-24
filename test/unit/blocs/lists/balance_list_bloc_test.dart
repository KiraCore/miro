import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/balance_list_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/providers/network_provider/network_events.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/list/sorting_status.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/models/wallet/saifu_wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/pages/balances_comparator.dart';
import 'package:miro/test/test_locator.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/lists/balance_list_bloc_test.dart --platform chrome
Future<void> main() async {
  // Actual values for tests
  final NetworkModel actualNetworkModel = NetworkModel(
    name: 'online.kira.network',
    url: 'https://online.kira.network',
    status: NetworkHealthStatus.unknown,
  );

  // Expected values for tests
  Set<Balance> expectedAllBalancesDenomAsc = <Balance>{
    const Balance(amount: '123123.12341', denom: 'AAB'),
    const Balance(amount: '123123.12342', denom: 'AAC'),
    const Balance(amount: '123123.12343', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
    const Balance(amount: '123123.12344', denom: 'AAE'),
    const Balance(amount: '123123.12345', denom: 'AAF'),
    const Balance(amount: '123123.12346', denom: 'AAG'),
    const Balance(amount: '123123.12347', denom: 'AAH'),
    const Balance(amount: '123123.12348', denom: 'AAI'),
    const Balance(amount: '123123.12349', denom: 'AAJ'),
    const Balance(amount: '0.9999', denom: 'ADA'),
    const Balance(amount: '123123.12310', denom: 'BCH'),
    const Balance(amount: '1.124334', denom: 'BNB'),
    const Balance(amount: '1234', denom: 'BTC'),
    const Balance(amount: '98236', denom: 'CRO'),
    const Balance(amount: '0.00001', denom: 'DOT'),
    const Balance(amount: '666999', denom: 'ETH'),
    const Balance(amount: '12344', denom: 'LTC'),
    const Balance(amount: '8374928743', denom: 'SOL'),
    const Balance(amount: '994999', denom: 'ukex'),
    const Balance(amount: '0.000342101', denom: 'UNI'),
    const Balance(amount: '0.235', denom: 'USDT'),
    const Balance(amount: '1.55', denom: 'XCH'),
    const Balance(amount: '1', denom: 'XLM'),
    const Balance(amount: '0.000012341', denom: 'XRP'),
  };

  Set<Balance> expectedAllBalancesAmountAsc = <Balance>{
    const Balance(amount: '0.00001', denom: 'DOT'),
    const Balance(amount: '0.000012341', denom: 'XRP'),
    const Balance(amount: '0.000342101', denom: 'UNI'),
    const Balance(amount: '0.235', denom: 'USDT'),
    const Balance(amount: '0.9999', denom: 'ADA'),
    const Balance(amount: '1', denom: 'XLM'),
    const Balance(amount: '1.124334', denom: 'BNB'),
    const Balance(amount: '1.55', denom: 'XCH'),
    const Balance(amount: '1234', denom: 'BTC'),
    const Balance(amount: '12344', denom: 'LTC'),
    const Balance(amount: '98236', denom: 'CRO'),
    const Balance(amount: '123123.12310', denom: 'BCH'),
    const Balance(amount: '123123.12349', denom: 'AAJ'),
    const Balance(amount: '123123.12348', denom: 'AAI'),
    const Balance(amount: '123123.12347', denom: 'AAH'),
    const Balance(amount: '123123.12346', denom: 'AAG'),
    const Balance(amount: '123123.12345', denom: 'AAF'),
    const Balance(amount: '123123.12344', denom: 'AAE'),
    const Balance(amount: '123123.12343', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
    const Balance(amount: '123123.12342', denom: 'AAC'),
    const Balance(amount: '123123.12341', denom: 'AAB'),
    const Balance(amount: '666999', denom: 'ETH'),
    const Balance(amount: '994999', denom: 'ukex'),
    const Balance(amount: '8374928743', denom: 'SOL'),
  };

  // Init tests
  await initTestLocator();
  await globalLocator<CacheManager>().init();

  globalLocator<WalletProvider>().updateWallet(
    SaifuWallet.fromAddress(
      address: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
    ),
  );
  globalLocator<NetworkProvider>().handleEvent(ConnectToNetworkEvent(actualNetworkModel));
  globalLocator<NetworkProvider>().handleEvent(SetUpNetworkEvent(actualNetworkModel));

  BalanceListBloc balanceListBloc = BalanceListBloc(
    networkProvider: globalLocator<NetworkProvider>(),
    queryBalanceService: globalLocator<QueryBalanceService>(),
    walletProvider: globalLocator<WalletProvider>(),
  )..add(InitListEvent());

  // Wait for download list data
  await Future<void>.delayed(const Duration(seconds: 1));

  group('Tests of initList() method', () {
    test('Should return ListLoadedState with first page data', () {
      Set<Balance> expectedFirstPageItems = <Balance>{
        const Balance(amount: '123123.12341', denom: 'AAB'),
        const Balance(amount: '123123.12342', denom: 'AAC'),
        const Balance(amount: '123123.12343', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
        const Balance(amount: '123123.12344', denom: 'AAE'),
        const Balance(amount: '123123.12345', denom: 'AAF'),
        const Balance(amount: '123123.12346', denom: 'AAG'),
        const Balance(amount: '123123.12347', denom: 'AAH'),
        const Balance(amount: '123123.12348', denom: 'AAI'),
        const Balance(amount: '123123.12349', denom: 'AAJ'),
        const Balance(amount: '0.9999', denom: 'ADA'),
      };

      expect(
        balanceListBloc.state,
        ListLoadedState<Balance>(
          currentPageIndex: 0,
          maxPagesIndex: 2,
          listEndStatus: false,
          itemsFromStart: expectedFirstPageItems,
          pageListItems: expectedFirstPageItems,
          allListItems: expectedAllBalancesDenomAsc,
        ),
      );
    });
  });

  group('Tests of method GoToPageEvent()', () {
    test('Should return ListLoadedState with second page data', () async {
      balanceListBloc.add(GoToPageEvent(1));
      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<Balance> expectedFirstPageItems = <Balance>{
        const Balance(amount: '123123.12341', denom: 'AAB'),
        const Balance(amount: '123123.12342', denom: 'AAC'),
        const Balance(amount: '123123.12343', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
        const Balance(amount: '123123.12344', denom: 'AAE'),
        const Balance(amount: '123123.12345', denom: 'AAF'),
        const Balance(amount: '123123.12346', denom: 'AAG'),
        const Balance(amount: '123123.12347', denom: 'AAH'),
        const Balance(amount: '123123.12348', denom: 'AAI'),
        const Balance(amount: '123123.12349', denom: 'AAJ'),
        const Balance(amount: '0.9999', denom: 'ADA'),
      };

      Set<Balance> expectedSecondPageItems = <Balance>{
        const Balance(amount: '123123.12310', denom: 'BCH'),
        const Balance(amount: '1.124334', denom: 'BNB'),
        const Balance(amount: '1234', denom: 'BTC'),
        const Balance(amount: '98236', denom: 'CRO'),
        const Balance(amount: '0.00001', denom: 'DOT'),
        const Balance(amount: '666999', denom: 'ETH'),
        const Balance(amount: '12344', denom: 'LTC'),
        const Balance(amount: '8374928743', denom: 'SOL'),
        const Balance(amount: '994999', denom: 'ukex'),
        const Balance(amount: '0.000342101', denom: 'UNI'),
      };

      expect(
        balanceListBloc.state,
        ListSortedState<Balance>(
          currentPageIndex: 1,
          maxPagesIndex: 2,
          listEndStatus: false,
          itemsFromStart: <Balance>{
            ...expectedFirstPageItems,
            ...expectedSecondPageItems,
          },
          pageListItems: expectedSecondPageItems,
          allListItems: expectedAllBalancesDenomAsc,
        ),
      );
    });
  });

  group('Tests of method SortEvent()', () {
    test('Should return ListSortedState with items sorted by name ascending', () async {
      balanceListBloc.add(
        SortEvent<Balance>(
          BalancesComparator().getSortOption(BalanceSortOption.name).copyWith(
                sortingStatus: SortingStatus.asc,
              ),
        ),
      );
      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<Balance> expectedFirstPageItems = <Balance>{
        const Balance(amount: '123123.12341', denom: 'AAB'),
        const Balance(amount: '123123.12342', denom: 'AAC'),
        const Balance(amount: '123123.12343', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
        const Balance(amount: '123123.12344', denom: 'AAE'),
        const Balance(amount: '123123.12345', denom: 'AAF'),
        const Balance(amount: '123123.12346', denom: 'AAG'),
        const Balance(amount: '123123.12347', denom: 'AAH'),
        const Balance(amount: '123123.12348', denom: 'AAI'),
        const Balance(amount: '123123.12349', denom: 'AAJ'),
        const Balance(amount: '0.9999', denom: 'ADA'),
      };

      Set<Balance> expectedSecondPageItems = <Balance>{
        const Balance(amount: '123123.12310', denom: 'BCH'),
        const Balance(amount: '1.124334', denom: 'BNB'),
        const Balance(amount: '1234', denom: 'BTC'),
        const Balance(amount: '98236', denom: 'CRO'),
        const Balance(amount: '0.00001', denom: 'DOT'),
        const Balance(amount: '666999', denom: 'ETH'),
        const Balance(amount: '12344', denom: 'LTC'),
        const Balance(amount: '8374928743', denom: 'SOL'),
        const Balance(amount: '994999', denom: 'ukex'),
        const Balance(amount: '0.000342101', denom: 'UNI'),
      };

      expect(
        balanceListBloc.state,
        ListSortedState<Balance>(
          currentPageIndex: 1,
          maxPagesIndex: 2,
          listEndStatus: false,
          itemsFromStart: <Balance>{
            ...expectedFirstPageItems,
            ...expectedSecondPageItems,
          },
          pageListItems: expectedSecondPageItems,
          allListItems: expectedAllBalancesDenomAsc,
        ),
      );
    });

    test('Should return ListSortedState with items sorted by name descending', () async {
      balanceListBloc.add(
        SortEvent<Balance>(
          BalancesComparator().getSortOption(BalanceSortOption.name).copyWith(
                sortingStatus: SortingStatus.desc,
              ),
        ),
      );

      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<Balance> expectedFirstPageItems = <Balance>{
        const Balance(amount: '0.000012341', denom: 'XRP'),
        const Balance(amount: '1', denom: 'XLM'),
        const Balance(amount: '0.235', denom: 'USDT'),
        const Balance(amount: '0.000342101', denom: 'UNI'),
        const Balance(amount: '994999', denom: 'ukex'),
        const Balance(amount: '8374928743', denom: 'SOL'),
        const Balance(amount: '12344', denom: 'LTC'),
        const Balance(amount: '666999', denom: 'ETH'),
        const Balance(amount: '0.00001', denom: 'DOT'),
        const Balance(amount: '1.55', denom: 'XCH'),
      };

      Set<Balance> expectedSecondPageItems = <Balance>{
        const Balance(amount: '98236', denom: 'CRO'),
        const Balance(amount: '1234', denom: 'BTC'),
        const Balance(amount: '1.124334', denom: 'BNB'),
        const Balance(amount: '123123.12310', denom: 'BCH'),
        const Balance(amount: '0.9999', denom: 'ADA'),
        const Balance(amount: '123123.12349', denom: 'AAJ'),
        const Balance(amount: '123123.12348', denom: 'AAI'),
        const Balance(amount: '123123.12347', denom: 'AAH'),
        const Balance(amount: '123123.12346', denom: 'AAG'),
        const Balance(amount: '123123.12345', denom: 'AAF'),
      };

      expect(
        balanceListBloc.state,
        ListSortedState<Balance>(
          currentPageIndex: 1,
          maxPagesIndex: 2,
          listEndStatus: false,
          itemsFromStart: <Balance>{
            ...expectedFirstPageItems,
            ...expectedSecondPageItems,
          },
          pageListItems: expectedSecondPageItems,
          allListItems: expectedAllBalancesDenomAsc.toList().reversed.toSet(),
        ),
      );
    });

    test('Should return ListSortedState with items sorted by amount ascending', () async {
      balanceListBloc.add(
        SortEvent<Balance>(
          BalancesComparator().getSortOption(BalanceSortOption.amount).copyWith(
                sortingStatus: SortingStatus.asc,
              ),
        ),
      );
      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<Balance> expectedFirstPageItems = <Balance>{
        const Balance(amount: '0.00001', denom: 'DOT'),
        const Balance(amount: '0.000012341', denom: 'XRP'),
        const Balance(amount: '0.000342101', denom: 'UNI'),
        const Balance(amount: '0.235', denom: 'USDT'),
        const Balance(amount: '0.9999', denom: 'ADA'),
        const Balance(amount: '1', denom: 'XLM'),
        const Balance(amount: '1.124334', denom: 'BNB'),
        const Balance(amount: '1.55', denom: 'XCH'),
        const Balance(amount: '1234', denom: 'BTC'),
        const Balance(amount: '12344', denom: 'LTC'),
      };

      Set<Balance> expectedSecondPageItems = <Balance>{
        const Balance(amount: '98236', denom: 'CRO'),
        const Balance(amount: '123123.12310', denom: 'BCH'),
        const Balance(amount: '123123.12341', denom: 'AAB'),
        const Balance(amount: '123123.12342', denom: 'AAC'),
        const Balance(amount: '123123.12343', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
        const Balance(amount: '123123.12344', denom: 'AAE'),
        const Balance(amount: '123123.12345', denom: 'AAF'),
        const Balance(amount: '123123.12346', denom: 'AAG'),
        const Balance(amount: '123123.12347', denom: 'AAH'),
        const Balance(amount: '123123.12348', denom: 'AAI'),
      };

      expect(
        balanceListBloc.state,
        ListSortedState<Balance>(
          currentPageIndex: 1,
          maxPagesIndex: 2,
          listEndStatus: false,
          itemsFromStart: <Balance>{
            ...expectedFirstPageItems,
            ...expectedSecondPageItems,
          },
          pageListItems: expectedSecondPageItems,
          allListItems: expectedAllBalancesAmountAsc,
        ),
      );
    });

    test('Should return ListSortedState with items sorted by amount descending', () async {
      balanceListBloc.add(
        SortEvent<Balance>(
          BalancesComparator().getSortOption(BalanceSortOption.amount).copyWith(
                sortingStatus: SortingStatus.desc,
              ),
        ),
      );

      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<Balance> expectedFirstPageItems = <Balance>{
        const Balance(amount: '8374928743', denom: 'SOL'),
        const Balance(amount: '994999', denom: 'ukex'),
        const Balance(amount: '666999', denom: 'ETH'),
        const Balance(amount: '123123.12349', denom: 'AAJ'),
        const Balance(amount: '123123.12348', denom: 'AAI'),
        const Balance(amount: '123123.12347', denom: 'AAH'),
        const Balance(amount: '123123.12346', denom: 'AAG'),
        const Balance(amount: '123123.12345', denom: 'AAF'),
        const Balance(amount: '123123.12344', denom: 'AAE'),
        const Balance(amount: '123123.12343', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
      };

      Set<Balance> expectedSecondPageItems = <Balance>{
        const Balance(amount: '123123.12342', denom: 'AAC'),
        const Balance(amount: '123123.12341', denom: 'AAB'),
        const Balance(amount: '123123.12310', denom: 'BCH'),
        const Balance(amount: '98236', denom: 'CRO'),
        const Balance(amount: '12344', denom: 'LTC'),
        const Balance(amount: '1234', denom: 'BTC'),
        const Balance(amount: '1.55', denom: 'XCH'),
        const Balance(amount: '1.124334', denom: 'BNB'),
        const Balance(amount: '1', denom: 'XLM'),
        const Balance(amount: '0.9999', denom: 'ADA'),
      };

      expect(
        balanceListBloc.state,
        ListSortedState<Balance>(
          currentPageIndex: 1,
          maxPagesIndex: 2,
          listEndStatus: false,
          itemsFromStart: <Balance>{
            ...expectedFirstPageItems,
            ...expectedSecondPageItems,
          },
          pageListItems: expectedSecondPageItems,
          allListItems: expectedAllBalancesAmountAsc.toList().reversed.toSet(),
        ),
      );
    });
  });

  group('Tests of AddFilterEvent()', () {
    test('Should return ListFilteredState with balances having amount bigger than one', () async {
      balanceListBloc.add(
        AddFilterEvent<Balance>(
          BalancesComparator().getFilterOption(BalanceFilterOption.smallBalances),
        ),
      );

      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<Balance> expectedFirstPageItems = <Balance>{
        const Balance(amount: '8374928743', denom: 'SOL'),
        const Balance(amount: '994999', denom: 'ukex'),
        const Balance(amount: '666999', denom: 'ETH'),
        const Balance(amount: '123123.12349', denom: 'AAJ'),
        const Balance(amount: '123123.12348', denom: 'AAI'),
        const Balance(amount: '123123.12347', denom: 'AAH'),
        const Balance(amount: '123123.12346', denom: 'AAG'),
        const Balance(amount: '123123.12345', denom: 'AAF'),
        const Balance(amount: '123123.12344', denom: 'AAE'),
        const Balance(amount: '123123.12343', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
      };

      expect(
        balanceListBloc.state,
        ListFilteredState<Balance>(
            currentPageIndex: 0,
            maxPagesIndex: 1,
            listEndStatus: false,
            itemsFromStart: expectedFirstPageItems,
            pageListItems: expectedFirstPageItems,
            allListItems: <Balance>{
              ...expectedFirstPageItems,
              const Balance(amount: '123123.12342', denom: 'AAC'),
              const Balance(amount: '123123.12341', denom: 'AAB'),
              const Balance(amount: '123123.12310', denom: 'BCH'),
              const Balance(amount: '98236', denom: 'CRO'),
              const Balance(amount: '12344', denom: 'LTC'),
              const Balance(amount: '1234', denom: 'BTC'),
              const Balance(amount: '1.55', denom: 'XCH'),
              const Balance(amount: '1.124334', denom: 'BNB'),
            }),
      );
    });
  });

  group('Tests of SearchEvent()', () {
    test('Should return ListSearchedState with balances matching provided pattern', () async {
      balanceListBloc.add(
        SearchEvent<Balance>(
          (Balance item) => BalancesComparator.filterSearch(item, 'KEX'),
        ),
      );

      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<Balance> expectedFirstPageItems = <Balance>{
        const Balance(amount: '994999', denom: 'ukex'),
      };

      expect(
        balanceListBloc.state,
        ListSearchedState<Balance>(
          currentPageIndex: 0,
          maxPagesIndex: 0,
          listEndStatus: true,
          itemsFromStart: expectedFirstPageItems,
          pageListItems: expectedFirstPageItems,
          allListItems: expectedFirstPageItems,
        ),
      );
    });

    test('Should return ListSearchedState with balances matching provided pattern', () async {
      balanceListBloc.add(
        SearchEvent<Balance>(
          (Balance item) => BalancesComparator.filterSearch(item, '994'),
        ),
      );

      // Wait for event finished
      await Future<void>.delayed(const Duration(seconds: 1));

      Set<Balance> expectedFirstPageItems = <Balance>{
        const Balance(amount: '994999', denom: 'ukex'),
      };

      expect(
        balanceListBloc.state,
        ListSearchedState<Balance>(
          currentPageIndex: 0,
          maxPagesIndex: 0,
          listEndStatus: true,
          itemsFromStart: expectedFirstPageItems,
          pageListItems: expectedFirstPageItems,
          allListItems: expectedFirstPageItems,
        ),
      );
    });
  });
}
