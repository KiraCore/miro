import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_amount.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_denomination.dart';

void main() {
  TokenDenomination defaultTokenDenomination = const TokenDenomination(name: 'KEX', decimals: 6);
  TokenDenomination lowestTokenDenomination = const TokenDenomination(name: 'ukex', decimals: 0);

  group('Tests of calculateAmountAsDenomination() method', () {
    test('Should return unchanged amount when new token denomination is equal to the old one', () {
      TokenAmount actualTokenAmount = TokenAmount(
        tokenDenomination: defaultTokenDenomination,
        amount: Decimal.parse('5'),
      );
      expect(
        actualTokenAmount.calculateAmountAsDenomination(defaultTokenDenomination).toString(),
        '5',
      );
    });

    test('Should return unchanged amount when new token denomination is equal to the old one', () {
      TokenAmount actualTokenAmount = TokenAmount(
        tokenDenomination: lowestTokenDenomination,
        amount: Decimal.parse('5'),
      );
      expect(
        actualTokenAmount.calculateAmountAsDenomination(lowestTokenDenomination).toString(),
        '5',
      );
    });

    test('Should return amount calculated from new denomination when new token denomination is different', () {
      TokenAmount actualTokenAmount = TokenAmount(
        tokenDenomination: lowestTokenDenomination,
        amount: Decimal.parse('122'),
      );
      expect(
        actualTokenAmount.calculateAmountAsDenomination(defaultTokenDenomination).toString(),
        '0.000122',
      );
    });

    test('Should return amount calculated from new denomination when new token denomination is different', () {
      TokenAmount actualTokenAmount = TokenAmount(
        tokenDenomination: defaultTokenDenomination,
        amount: Decimal.parse('0.000122'),
      );
      expect(
        actualTokenAmount.calculateAmountAsDenomination(lowestTokenDenomination).toString(),
        '122',
      );
    });

    // Tests of parsing very big or very small numbers
    test('Should return amount calculated from new denomination without rounding or scientific notation', () {
      TokenAmount actualTokenAmount = TokenAmount(
        tokenDenomination: lowestTokenDenomination,
        amount: Decimal.parse('0.000000000000000000000000000122'),
      );
      expect(
        actualTokenAmount.calculateAmountAsDenomination(defaultTokenDenomination).toString(),
        '0.000000000000000000000000000000000122',
      );
    });

    test('Should return amount calculated from new denomination without rounding or scientific notation', () {
      TokenAmount actualTokenAmount = TokenAmount(
        tokenDenomination: lowestTokenDenomination,
        amount: Decimal.parse('0.000000000000000000000000000000000000000000000000000000122'),
      );
      expect(
        actualTokenAmount.calculateAmountAsDenomination(defaultTokenDenomination).toString(),
        '0.000000000000000000000000000000000000000000000000000000000000122',
      );
    });

    test('Should return amount calculated from new denomination without rounding or scientific notation', () {
      TokenAmount actualTokenAmount = TokenAmount(
        tokenDenomination: defaultTokenDenomination,
        amount: Decimal.parse('123456789123456789123456789'),
      );
      expect(
        actualTokenAmount.calculateAmountAsDenomination(lowestTokenDenomination).toString(),
        '123456789123456789123456789000000',
      );
    });

    test('Should return amount calculated from new denomination without rounding or scientific notation', () {
      TokenAmount actualTokenAmount = TokenAmount(
        tokenDenomination: defaultTokenDenomination,
        amount: Decimal.parse('123456789123456789123456789123456789123456789123456789'),
      );
      expect(
        actualTokenAmount.calculateAmountAsDenomination(lowestTokenDenomination).toString(),
        '123456789123456789123456789123456789123456789123456789000000',
      );
    });
  });
}
