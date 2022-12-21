import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/dto/api_kira/query_balance/response/balance.dart';
import 'package:miro/shared/utils/pages/balances_comparator.dart';

void main() {
  // Actual values for tests
  Set<Balance> actualAllBalances = <Balance>{
    const Balance(amount: '0.9999', denom: 'ADA'),
    const Balance(amount: '123123.12344', denom: 'BCH'),
    const Balance(amount: '1.124334', denom: 'BNB'),
    const Balance(amount: '1234', denom: 'BTC'),
    const Balance(amount: '98236', denom: 'CRO'),
    const Balance(amount: '0.00001', denom: 'DOT'),
    const Balance(amount: '666999', denom: 'ETH'),
    const Balance(amount: '12344', denom: 'LTC'),
  };

  group('Tests of Balances.sortByAmount() method', () {
    test('Should return 0 (Amounts equal)', () {
      expect(
        BalancesComparator.sortByAmount(
          const Balance(amount: '1.55', denom: 'XCH'),
          const Balance(amount: '1.55', denom: 'XCH'),
        ),
        0,
      );
    });

    test('Should return 1 (First amount greater than second)', () {
      expect(
        BalancesComparator.sortByAmount(
          const Balance(amount: '1.55', denom: 'XCH'),
          const Balance(amount: '1', denom: 'AAE'),
        ),
        1,
      );
    });

    test('Should return -1 (First amount less than second)', () {
      expect(
        BalancesComparator.sortByAmount(
          const Balance(amount: '1', denom: 'AAE'),
          const Balance(amount: '1.55', denom: 'XCH'),
        ),
        -1,
      );
    });

    test('Should return list sorted by amount', () {
      List<Balance> actualBalances = actualAllBalances.toList()..sort(BalancesComparator.sortByAmount);
      expect(
        actualBalances,
        <Balance>[
          const Balance(amount: '0.00001', denom: 'DOT'),
          const Balance(amount: '0.9999', denom: 'ADA'),
          const Balance(amount: '1.124334', denom: 'BNB'),
          const Balance(amount: '1234', denom: 'BTC'),
          const Balance(amount: '12344', denom: 'LTC'),
          const Balance(amount: '98236', denom: 'CRO'),
          const Balance(amount: '123123.12344', denom: 'BCH'),
          const Balance(amount: '666999', denom: 'ETH'),
        ],
      );
    });
  });

  group('Tests of Balances.sortByName() method', () {
    test('Should return 0 (Names equal)', () {
      expect(
        BalancesComparator.sortByAmount(
          const Balance(amount: '1.55', denom: 'XCH'),
          const Balance(amount: '1.55', denom: 'XCH'),
        ),
        0,
      );
    });

    test('Should return 1 (First name greater than second)', () {
      expect(
        BalancesComparator.sortByAmount(
          const Balance(amount: '1.55', denom: 'XCH'),
          const Balance(amount: '1', denom: 'AAE'),
        ),
        1,
      );
    });

    test('Should return -1 (First name less than second)', () {
      expect(
        BalancesComparator.sortByAmount(
          const Balance(amount: '1', denom: 'AAE'),
          const Balance(amount: '1.55', denom: 'XCH'),
        ),
        -1,
      );
    });

    test('Should return list sorted by name', () {
      List<Balance> actualBalances = actualAllBalances.toList()..sort(BalancesComparator.sortByName);
      expect(
        actualBalances,
        <Balance>[
          const Balance(amount: '0.9999', denom: 'ADA'),
          const Balance(amount: '123123.12344', denom: 'BCH'),
          const Balance(amount: '1.124334', denom: 'BNB'),
          const Balance(amount: '1234', denom: 'BTC'),
          const Balance(amount: '98236', denom: 'CRO'),
          const Balance(amount: '0.00001', denom: 'DOT'),
          const Balance(amount: '666999', denom: 'ETH'),
          const Balance(amount: '12344', denom: 'LTC'),
        ],
      );
    });
  });

  group('Tests of Balances.filterSmallBalances() method', () {
    test('Should return true if balance greater than one', () {
      expect(
        BalancesComparator.filterSmallBalances(
          const Balance(amount: '1.55', denom: 'XCH'),
        ),
        true,
      );
    });

    test('Should return false if balance less than one', () {
      expect(
        BalancesComparator.filterSmallBalances(
          const Balance(amount: '0.001', denom: 'XCH'),
        ),
        false,
      );
    });

    test('Should return list filtered by small balances', () {
      List<Balance> actualBalances = actualAllBalances.where(BalancesComparator.filterSmallBalances).toList();
      expect(
        actualBalances,
        <Balance>[
          const Balance(amount: '123123.12344', denom: 'BCH'),
          const Balance(amount: '1.124334', denom: 'BNB'),
          const Balance(amount: '1234', denom: 'BTC'),
          const Balance(amount: '98236', denom: 'CRO'),
          const Balance(amount: '666999', denom: 'ETH'),
          const Balance(amount: '12344', denom: 'LTC'),
        ],
      );
    });
  });

  group('Tests of Balances.filterSearch() method', () {
    test('Should return true if balance contains provided String', () {
      expect(
        BalancesComparator.filterSearch(
          const Balance(amount: '1.55', denom: 'XCH'),
          'XC',
        ),
        true,
      );
    });

    test('Should return true if balance contains provided String', () {
      expect(
        BalancesComparator.filterSearch(
          const Balance(amount: '1.55', denom: 'XCH'),
          '55',
        ),
        true,
      );
    });

    test('Should return false if balance not contains provided String', () {
      expect(
        BalancesComparator.filterSearch(
          const Balance(amount: '1.55', denom: 'XCH'),
          'Kira',
        ),
        false,
      );
    });

    test('Should return false if balance not contains provided String', () {
      expect(
        BalancesComparator.filterSearch(
          const Balance(amount: '1.55', denom: 'XCH'),
          '72',
        ),
        false,
      );
    });

    test('Should return list filtered by search value', () {
      List<Balance> actualBalances =
          actualAllBalances.where((Balance item) => BalancesComparator.filterSearch(item, '123')).toList();
      expect(
        actualBalances,
        <Balance>[
          const Balance(amount: '123123.12344', denom: 'BCH'),
          const Balance(amount: '1234', denom: 'BTC'),
          const Balance(amount: '12344', denom: 'LTC'),
        ],
      );
    });
  });
}
