import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:miro/blocs/abstract_blocs/list_bloc/list_bloc.dart';
import 'package:miro/blocs/specific_blocs/lists/balance_list_bloc.dart';
import 'package:miro/config/hive.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/balance.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/providers/network_provider/network_events.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/pages/balances_comparator.dart';
import 'package:miro/test/test_locator.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sort_option.dart';
import 'package:miro/views/widgets/kira/kira_list/models/sorting_status.dart';

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
  Set<Balance> expectedAllBalances = <Balance>{
    const Balance(amount: '123123.12344', denom: 'AAB'),
    const Balance(amount: '123123.12344', denom: 'AAC'),
    const Balance(amount: '123123.12344', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
    const Balance(amount: '123123.12344', denom: 'AAE'),
    const Balance(amount: '123123.12344', denom: 'AAF'),
    const Balance(amount: '123123.12344', denom: 'AAG'),
    const Balance(amount: '123123.12344', denom: 'AAH'),
    const Balance(amount: '123123.12344', denom: 'AAI'),
    const Balance(amount: '123123.12344', denom: 'AAJ'),
    const Balance(amount: '0.9999', denom: 'ADA'),
    const Balance(amount: '123123.12344', denom: 'BCH'),
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

  // Init tests
  await Hive.initFlutter();
  await initHive();
  await initTestLocator();

  // @formatter:off
  const String actualMnemonicString =
      'equal success expand debris crash despair awake bachelor athlete discover drop tilt reveal give oven polar party exact sign chalk hurdle move tilt chronic';
  final Mnemonic actualMnemonic = Mnemonic(value: actualMnemonicString);
  final Wallet actualWallet = Wallet.derive(mnemonic: actualMnemonic);
  // @formatter:on
  
  globalLocator<WalletProvider>().updateWallet(actualWallet);
  globalLocator<NetworkProvider>().handleEvent(ConnectToNetworkEvent(actualNetworkModel));
  globalLocator<NetworkProvider>().handleEvent(SetUpNetworkEvent(actualNetworkModel));
  
  BalanceListBloc balanceListBloc = BalanceListBloc(
    networkProvider: globalLocator<NetworkProvider>(),
    queryBalanceService: globalLocator<QueryBalanceService>(),
    walletProvider: globalLocator<WalletProvider>(),
  )..add(InitListEvent());

  await Future<void>.delayed(const Duration(seconds: 1));

  group('Tests of initList() method', () {
    Set<Balance> expectedCurrentBalances = expectedAllBalances.toList().sublist(0, ListBloc.pageSize).toSet();

    test('Should return current list size that is equal to ListCubit.pageSize', () {
      expect(
        expectedCurrentBalances.length,
        ListBloc.pageSize,
      );
    });

    test('Should return current list items', () {
      expect(
        balanceListBloc.visibleListItems,
        expectedCurrentBalances,
      );
    });

    test('Should return all downloaded list items', () {
      expect(
        balanceListBloc.allListItems,
        expectedAllBalances,
      );
    });
  });

  group('Tests of method sort()', () {
    test('Should return current list items sorted by denom ascending', () {
      balanceListBloc.add(SortEvent<Balance>(
        const SortOption<Balance>(
          name: 'name',
          comparator: BalancesComparator.sortByName,
          sortingStatus: SortingStatus.asc,
        ),
      ));
      expect(
        balanceListBloc.visibleListItems,
        const <Balance>[
          Balance(amount: '123123.12344', denom: 'AAB'),
          Balance(amount: '123123.12344', denom: 'AAC'),
          Balance(amount: '123123.12344', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
          Balance(amount: '123123.12344', denom: 'AAE'),
          Balance(amount: '123123.12344', denom: 'AAF'),
          Balance(amount: '123123.12344', denom: 'AAG'),
          Balance(amount: '123123.12344', denom: 'AAH'),
          Balance(amount: '123123.12344', denom: 'AAI'),
          Balance(amount: '123123.12344', denom: 'AAJ'),
          Balance(amount: '0.9999', denom: 'ADA'),
          Balance(amount: '123123.12344', denom: 'BCH'),
          Balance(amount: '1.124334', denom: 'BNB'),
          Balance(amount: '1234', denom: 'BTC'),
          Balance(amount: '98236', denom: 'CRO'),
          Balance(amount: '0.00001', denom: 'DOT'),
          Balance(amount: '666999', denom: 'ETH'),
          Balance(amount: '12344', denom: 'LTC'),
          Balance(amount: '8374928743', denom: 'SOL'),
          Balance(amount: '994999', denom: 'ukex'),
          Balance(amount: '0.000342101', denom: 'UNI'),
        ],
      );
    });

    test('Should return current list items sorted by denom descending', () async {
      balanceListBloc.add(SortEvent<Balance>(
        const SortOption<Balance>(
          name: 'name',
          comparator: BalancesComparator.sortByName,
          sortingStatus: SortingStatus.desc,
        ),
      ));

      await Future<void>.delayed(const Duration(seconds: 1));

      expect(
        balanceListBloc.visibleListItems,
        const <Balance>[
          Balance(amount: '0.000342101', denom: 'UNI'),
          Balance(amount: '994999', denom: 'ukex'),
          Balance(amount: '8374928743', denom: 'SOL'),
          Balance(amount: '12344', denom: 'LTC'),
          Balance(amount: '666999', denom: 'ETH'),
          Balance(amount: '0.00001', denom: 'DOT'),
          Balance(amount: '98236', denom: 'CRO'),
          Balance(amount: '1234', denom: 'BTC'),
          Balance(amount: '1.124334', denom: 'BNB'),
          Balance(amount: '123123.12344', denom: 'BCH'),
          Balance(amount: '0.9999', denom: 'ADA'),
          Balance(amount: '123123.12344', denom: 'AAJ'),
          Balance(amount: '123123.12344', denom: 'AAI'),
          Balance(amount: '123123.12344', denom: 'AAH'),
          Balance(amount: '123123.12344', denom: 'AAG'),
          Balance(amount: '123123.12344', denom: 'AAF'),
          Balance(amount: '123123.12344', denom: 'AAE'),
          Balance(amount: '123123.12344', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
          Balance(amount: '123123.12344', denom: 'AAC'),
          Balance(amount: '123123.12344', denom: 'AAB'),
        ],
      );
    });

    test('Should return current list items sorted by amount ascending', () async {
      balanceListBloc.add(SortEvent<Balance>(
        const SortOption<Balance>(
          name: 'amount',
          comparator: BalancesComparator.sortByAmount,
          sortingStatus: SortingStatus.desc,
        ),
      ));
      await Future<void>.delayed(const Duration(seconds: 1));
      expect(
        balanceListBloc.visibleListItems,
        const <Balance>[
          Balance(amount: '8374928743', denom: 'SOL'),
          Balance(amount: '994999', denom: 'ukex'),
          Balance(amount: '666999', denom: 'ETH'),
          Balance(amount: '123123.12344', denom: 'BCH'),
          Balance(amount: '123123.12344', denom: 'AAJ'),
          Balance(amount: '123123.12344', denom: 'AAI'),
          Balance(amount: '123123.12344', denom: 'AAH'),
          Balance(amount: '123123.12344', denom: 'AAG'),
          Balance(amount: '123123.12344', denom: 'AAF'),
          Balance(amount: '123123.12344', denom: 'AAE'),
          Balance(amount: '123123.12344', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
          Balance(amount: '123123.12344', denom: 'AAC'),
          Balance(amount: '123123.12344', denom: 'AAB'),
          Balance(amount: '98236', denom: 'CRO'),
          Balance(amount: '12344', denom: 'LTC'),
          Balance(amount: '1234', denom: 'BTC'),
          Balance(amount: '1.124334', denom: 'BNB'),
          Balance(amount: '0.9999', denom: 'ADA'),
          Balance(amount: '0.000342101', denom: 'UNI'),
          Balance(amount: '0.00001', denom: 'DOT'),
        ],
      );
    });

    test('Should return current list items sorted by amount descending', () async {
      balanceListBloc.add(SortEvent<Balance>(
        const SortOption<Balance>(
          name: 'amount',
          comparator: BalancesComparator.sortByAmount,
          sortingStatus: SortingStatus.asc,
        ),
      ));
      await Future<void>.delayed(const Duration(seconds: 1));
      expect(
        balanceListBloc.visibleListItems,
        const <Balance>[
          Balance(amount: '0.00001', denom: 'DOT'),
          Balance(amount: '0.000342101', denom: 'UNI'),
          Balance(amount: '0.9999', denom: 'ADA'),
          Balance(amount: '1.124334', denom: 'BNB'),
          Balance(amount: '1234', denom: 'BTC'),
          Balance(amount: '12344', denom: 'LTC'),
          Balance(amount: '98236', denom: 'CRO'),
          Balance(amount: '123123.12344', denom: 'BCH'),
          Balance(amount: '123123.12344', denom: 'AAJ'),
          Balance(amount: '123123.12344', denom: 'AAI'),
          Balance(amount: '123123.12344', denom: 'AAH'),
          Balance(amount: '123123.12344', denom: 'AAG'),
          Balance(amount: '123123.12344', denom: 'AAF'),
          Balance(amount: '123123.12344', denom: 'AAE'),
          Balance(amount: '123123.12344', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
          Balance(amount: '123123.12344', denom: 'AAC'),
          Balance(amount: '123123.12344', denom: 'AAB'),
          Balance(amount: '666999', denom: 'ETH'),
          Balance(amount: '994999', denom: 'ukex'),
          Balance(amount: '8374928743', denom: 'SOL'),
        ],
      );
    });
  });

  group('Tests of method filter()', () {
    test('Should return balances with amount bigger than one', () async {
      balanceListBloc.add(FilterEvent<Balance>(BalancesComparator.filterSmallBalances));
      await Future<void>.delayed(const Duration(seconds: 1));
      expect(
        balanceListBloc.visibleListItems,
        const <Balance>[
          Balance(amount: '1.124334', denom: 'BNB'),
          Balance(amount: '1.55', denom: 'XCH'),
          Balance(amount: '1234', denom: 'BTC'),
          Balance(amount: '12344', denom: 'LTC'),
          Balance(amount: '98236', denom: 'CRO'),
          Balance(amount: '123123.12344', denom: 'AAB'),
          Balance(amount: '123123.12344', denom: 'AAC'),
          Balance(amount: '123123.12344', denom: 'AACCBBDDEEFFGGHHIIJJKKWWBBSCDOFIANFIASJSADKASDKASD'),
          Balance(amount: '123123.12344', denom: 'AAE'),
          Balance(amount: '123123.12344', denom: 'AAF'),
          Balance(amount: '123123.12344', denom: 'AAG'),
          Balance(amount: '123123.12344', denom: 'AAH'),
          Balance(amount: '123123.12344', denom: 'AAI'),
          Balance(amount: '123123.12344', denom: 'AAJ'),
          Balance(amount: '123123.12344', denom: 'BCH'),
          Balance(amount: '666999', denom: 'ETH'),
          Balance(amount: '994999', denom: 'ukex'),
          Balance(amount: '8374928743', denom: 'SOL'),
        ],
      );
    });

    test('Should return balances with matching pattern', () async {
      balanceListBloc.add(SearchEvent<Balance>((Balance item) => BalancesComparator.filterSearch(item, 'KEX')));
      await Future<void>.delayed(const Duration(seconds: 1));
      expect(
        balanceListBloc.visibleListItems,
        <Balance>[
          const Balance(amount: '994999', denom: 'ukex'),
        ],
      );
    });

    test('Should return balances with matching pattern', () async {
      balanceListBloc.add(SearchEvent<Balance>((Balance item) => BalancesComparator.filterSearch(item, '994')));
      await Future<void>.delayed(const Duration(seconds: 1));
      expect(
        balanceListBloc.visibleListItems,
        <Balance>[
          const Balance(amount: '994999', denom: 'ukex'),
        ],
      );
    });
  });
}
