import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/i_tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/auth_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/mode_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/sign_mode.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/single_mode_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/signer_info.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_body.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_pub_key.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';

/// Standard type used for broadcasting transactions.
///
/// https://docs.cosmos.network/v0.44/core/proto-docs.html#cosmos.tx.v1beta1.Tx
class Tx {
  /// Processable content of the transaction
  final TxBody body;

  /// Authorization related content of the transaction,
  /// specifically signers, signer modes and fee
  final AuthInfo authInfo;

  /// List of signatures that matches the length and order of
  /// AuthInfo's signer_infos to allow connecting signature meta information like
  /// public key and signing mode by position.
  final List<String> signatures;

  const Tx({
    required this.body,
    required this.authInfo,
    required this.signatures,
  });

  factory Tx.fromSignedTxModel(SignedTxModel signedTxModel) {
    TxLocalInfoModel txLocalInfoModel = signedTxModel.txLocalInfoModel;
    TxRemoteInfoModel txRemoteInfoModel = signedTxModel.txRemoteInfoModel;

    SignerInfo signerInfo = SignerInfo(
      publicKey: TxPubKey(key: signedTxModel.publicKeyCompressed),
      modeInfo: const ModeInfo(single: SingleModeInfo(mode: SignMode.SIGN_MODE_LEGACY_AMINO_JSON)),
      sequence: txRemoteInfoModel.sequence,
    );

    return Tx(
      body: TxBody(
        messages: <ITxMsg>[txLocalInfoModel.txMsgModel.toMsgDto()],
        memo: txLocalInfoModel.memo,
      ),
      authInfo: AuthInfo(
        signerInfos: <SignerInfo>[signerInfo],
        fee: TxFee(
          amount: <Coin>[
            Coin.fromTokenAmountModel(txLocalInfoModel.feeTokenAmountModel),
          ],
        ),
      ),
      signatures: <String>[signedTxModel.signatureModel.signature],
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'body': body.toJson(),
        'auth_info': authInfo.toJson(),
        'signatures': signatures,
      };
}
