import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_amount.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_denomination.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_type.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/token_section_controller.dart';

void main() {
  WalletAddress walletAddress = WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');
  TokenDenomination defaultTokenDenomination = const TokenDenomination(name: 'KEX', decimals: 6);
  TokenDenomination lowestTokenDenomination = const TokenDenomination(name: 'ukex', decimals: 0);

  TokenType tokenType = TokenType(
    name: 'KEX',
    lowestTokenDenomination: lowestTokenDenomination,
    defaultTokenDenomination: defaultTokenDenomination,
  );

  group('Tests of TokenSectionController initial state', () {
    TokenSectionController tokenSectionController = TokenSectionController(walletAddress: walletAddress);

    test('Should return null if TokenSectionController has no changes', () {
      expect(
        tokenSectionController.selectedTokenType,
        null,
      );
    });

    test('Should return null if TokenSectionController has no changes', () {
      expect(
        tokenSectionController.sendTokenAmount,
        null,
      );
    });

    test('Should return null if TokenSectionController has no changes', () {
      expect(
        tokenSectionController.availableTokenAmount,
        null,
      );
    });

    test('Should return null if TokenSectionController has no changes', () {
      expect(
        tokenSectionController.save(),
        null,
      );
    });

    test('Should return empty String if TokenSectionController has no changes', () {
      expect(
        tokenSectionController.amountValueTextController.text,
        '',
      );
    });

    test('Should return error if TokenSectionController has no changes', () {
      expect(
        tokenSectionController.validate(),
        'Token is not selected',
      );
    });
  });

  group('Tests of TokenSectionController after call updateTokenType()', () {
    TokenSectionController tokenSectionController = TokenSectionController(walletAddress: walletAddress)
      ..updateTokenType(tokenType);
    test('Should return selected token type', () {
      expect(
        tokenSectionController.selectedTokenType,
        tokenType,
      );
    });

    test('Should return TokenAmount with "ukex" denomination and 0 amount', () {
      expect(
        tokenSectionController.sendTokenAmount,
        TokenAmount(tokenDenomination: tokenType.lowestTokenDenomination, amount: Decimal.zero),
      );
    });

    test('Should return TokenAmount with "ukex" denomination and 0 amount', () {
      expect(
        tokenSectionController.availableTokenAmount,
        TokenAmount(tokenDenomination: tokenType.lowestTokenDenomination, amount: Decimal.zero),
      );
    });

    test('Should return empty String if amount value is equal zero', () {
      expect(
        tokenSectionController.amountValueTextController.text,
        '',
      );
    });

    test('Should return null if TokenSection has no errors', () {
      expect(
        tokenSectionController.validate(),
        null,
      );
    });
  });

  group('Tests of TokenSectionController after call updateAmountValue()', () {
    TokenSectionController tokenSectionController = TokenSectionController(walletAddress: walletAddress)
      ..updateTokenType(tokenType)
      ..updateAmountValue('1');
    test('Should return selected token type', () {
      expect(
        tokenSectionController.selectedTokenType,
        tokenType,
      );
    });

    test('Should return TokenAmount with "ukex" denomination and 1 amount', () {
      expect(
        tokenSectionController.sendTokenAmount,
        TokenAmount(tokenDenomination: tokenType.lowestTokenDenomination, amount: Decimal.one),
      );
    });

    test('Should return TokenAmount with "ukex" denomination and 0 amount', () {
      expect(
        tokenSectionController.availableTokenAmount,
        TokenAmount(tokenDenomination: tokenType.lowestTokenDenomination, amount: Decimal.zero),
      );
    });

    test('Should return empty String if amount value is equal zero', () {
      expect(
        tokenSectionController.amountValueTextController.text,
        '1',
      );
    });

    test('Should return error if sendTokenAmount value is bigger than availableTokenAmount', () {
      expect(
        tokenSectionController.validate(),
        'Not enough tokens',
      );
    });
  });

  group('Tests of TokenSectionController after call updateTokenDenomination()', () {
    TokenSectionController tokenSectionController = TokenSectionController(walletAddress: walletAddress)
      ..updateTokenType(tokenType)
      ..updateAmountValue('1')
      ..updateTokenDenomination(defaultTokenDenomination);
    test('Should return selected token type', () {
      expect(
        tokenSectionController.selectedTokenType,
        tokenType,
      );
    });

    test('Should return TokenAmount with "KEX" denomination and 0.000001 amount', () {
      expect(
        tokenSectionController.sendTokenAmount,
        TokenAmount(tokenDenomination: tokenType.defaultTokenDenomination, amount: Decimal.parse('0.000001')),
      );
    });

    test('Should return TokenAmount with "KEX" denomination and 0 amount', () {
      expect(
        tokenSectionController.availableTokenAmount,
        TokenAmount(tokenDenomination: tokenType.defaultTokenDenomination, amount: Decimal.zero),
      );
    });

    test('Should return empty String if amount value is equal zero', () {
      expect(
        tokenSectionController.amountValueTextController.text,
        '0.000001',
      );
    });

    test('Should return error if sendTokenAmount value is bigger than availableTokenAmount', () {
      expect(
        tokenSectionController.validate(),
        'Not enough tokens',
      );
    });
  });
}
