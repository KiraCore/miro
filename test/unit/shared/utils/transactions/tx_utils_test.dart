import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';

Future<void> main() async {
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
      // @formatter:off
      Mnemonic mnemonic = Mnemonic.fromArray(array: <String>['require', 'point', 'property', 'company', 'tongue', 'busy', 'bench', 'burden', 'caution', 'gadget', 'knee', 'glance', 'thought', 'bulk', 'assist', 'month', 'cereal', 'report', 'quarter', 'tool', 'section', 'often', 'require', 'shield']);
      Wallet wallet = Wallet.derive(mnemonic: mnemonic);
      // @formatter:on

      TxRemoteInfoModel txRemoteInfoModel = const TxRemoteInfoModel(
        accountNumber: '669',
        chainId: 'testnet',
        sequence: '0',
      );

      TxLocalInfoModel txLocalInfoModel = TxLocalInfoModel(
        memo: 'Test transaction',
        feeTokenAmountModel: TokenAmountModel(
          lowestDenominationAmount: Decimal.fromInt(100),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
        txMsgModel: MsgSendModel(
          fromWalletAddress: wallet.address,
          toWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
          tokenAmountModel: TokenAmountModel(
            lowestDenominationAmount: Decimal.fromInt(100),
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
        wallet: wallet,
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
