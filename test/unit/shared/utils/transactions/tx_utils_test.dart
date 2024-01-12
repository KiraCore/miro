import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/utils/transactions/tx_utils_test.dart --platform chrome --null-assertions
Future<void> main() async {
  group('Tests of TxUtils.buildAmountString() method', () {
    // Arrange
    TokenDenominationModel ukex = const TokenDenominationModel(name: 'ukex', decimals: 0);
    TokenDenominationModel kex = const TokenDenominationModel(name: 'KEX', decimals: 6);

    test('Should return [the same amount] if [amount 0]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('0', kex);

      // Assert
      String expectedAmountString = '0';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should return [the same amount] if [amount contains decimal point]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('5.0', kex);

      // Assert
      String expectedAmountString = '5.0';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should return [the same amount] if [TokenDenominationModel indivisible]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('5', ukex);

      // Assert
      String expectedAmountString = '5';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should add [.0 suffix] if [no decimal point]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('5', kex);

      // Assert
      String expectedAmountString = '5.0';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should add [0 suffix] if amount [ends with decimal point]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('5.', kex);

      // Assert
      String expectedAmountString = '5.0';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should add [0 prefix] if amount [starts with decimal point]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('.5', kex);

      // Assert
      String expectedAmountString = '0.5';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should add [0 prefix] if amount [equals "."]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('.', kex);

      // Assert
      String expectedAmountString = '0.';
      expect(actualAmountString, expectedAmountString);
    });

    test('Should not change if [amount equals "0."]', () {
      // Act
      String actualAmountString = TxUtils.buildAmountString('0.', kex);

      // Assert
      String expectedAmountString = '0.';
      expect(actualAmountString, expectedAmountString);
    });
  });

  group('Tests of TxUtils.trimMemoToLength() method', () {
    test('Should return memo without overflowed characters (">>>>>>>>>>>>>>>>" -> ">")', () {
      // Act
      String actualTrimmedMemo = TxUtils.trimMemoToLength('>>>>>>>>>>>>>>>>', 6);

      // Assert
      String expectedTrimmedMemo = '>';
      expect(actualTrimmedMemo, expectedTrimmedMemo);
    });

    test('Should return memo without overflowed characters ("0123456789" -> "01234")', () {
      // Act
      String actualTrimmedMemo = TxUtils.trimMemoToLength('0123456789', 6);

      // Assert
      String expectedTrimmedMemo = '012345';
      expect(actualTrimmedMemo, expectedTrimmedMemo);
    });

    test('Should return memo without overflowed characters (">0123456789" -> ">")', () {
      // Act
      String actualTrimmedMemo = TxUtils.trimMemoToLength('>', 6);

      // Assert
      String expectedTrimmedMemo = '>';
      expect(actualTrimmedMemo, expectedTrimmedMemo);
    });

    test('Should return memo without overflowed characters ("0123456789>" -> "012345")', () {
      // Act
      String actualTrimmedMemo = TxUtils.trimMemoToLength('0123456789>', 6);

      // Assert
      String expectedTrimmedMemo = '012345';
      expect(actualTrimmedMemo, expectedTrimmedMemo);
    });
    test('Should return memo without overflowed characters ("<><>" -> "<>")', () {
      // Act
      String actualTrimmedMemo = TxUtils.trimMemoToLength('<><>', 12);

      // Assert
      String expectedTrimmedMemo = '<>';
      expect(actualTrimmedMemo, expectedTrimmedMemo);
    });
  });

  group('Tests of TxUtils.replaceMemoRestrictedChars() method', () {
    test('Should return memo with "<", ">" replaced to unicode characters', () {
      // Act
      String actualEncodedMemo = TxUtils.replaceMemoRestrictedChars('Test <memo> with < and >');

      // Assert
      String expectedEncodedMemo = r'Test \u003cmemo\u003e with \u003c and \u003e';
      expect(actualEncodedMemo, expectedEncodedMemo);
    });

    test('Should return unchanged memo for string without "<", ">"', () {
      // Act
      String actualEncodedMemo = TxUtils.replaceMemoRestrictedChars('Memo without restricted characters');

      // Assert
      String expectedEncodedMemo = 'Memo without restricted characters';
      expect(actualEncodedMemo, expectedEncodedMemo);
    });
  });

  group('Tests of TxUtils.sign() method', () {
    test('Should return SignedTxModel with generated signature', () {
      // Arrange
      TxRemoteInfoModel txRemoteInfoModel = const TxRemoteInfoModel(
        accountNumber: '669',
        chainId: 'testnet',
        sequence: '0',
      );

      TxLocalInfoModel txLocalInfoModel = TxLocalInfoModel(
        memo: 'Test transaction',
        feeTokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
        txMsgModel: MsgSendModel(
          fromWalletAddress: TestUtils.wallet.address,
          toWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
          tokenAmountModel: TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100),
            tokenAliasModel: TokenAliasModel.local('ukex'),
          ),
        ),
      );

      UnsignedTxModel actualUnsignedTxModel = UnsignedTxModel(
        txLocalInfoModel: txLocalInfoModel,
        txRemoteInfoModel: txRemoteInfoModel,
      );

      // Act
      SignedTxModel actualSignedTxModel = TxUtils.sign(
        unsignedTxModel: actualUnsignedTxModel,
        wallet: TestUtils.wallet,
      );

      // Assert
      SignedTxModel expectedSignedTxModel = SignedTxModel(
        publicKeyCompressed: 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
        txLocalInfoModel: txLocalInfoModel,
        txRemoteInfoModel: txRemoteInfoModel,
        signatureModel: const SignatureModel(
          signature: 'hd+WiCdVaMcTDshpEsgkn6VOWdXAOV7QKUZEIxMRhLYzSD8bK7RQcn9jl/2I2TLa4QBoCuAStXwOircabaVQzg==',
        ),
      );

      expect(actualSignedTxModel, expectedSignedTxModel);
    });
  });
}
