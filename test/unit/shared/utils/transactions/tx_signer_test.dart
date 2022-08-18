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
import 'package:miro/shared/utils/transactions/tx_signer.dart';

Future<void> main() async {
  group('Tests of TxSigner.sign() method', () {
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
      SignedTxModel actualSignedTxModel = TxSigner.sign(
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
