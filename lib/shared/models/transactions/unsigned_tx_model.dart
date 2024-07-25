import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

class UnsignedTxModel extends Equatable {
  final TxLocalInfoModel txLocalInfoModel;
  final TxRemoteInfoModel txRemoteInfoModel;

  const UnsignedTxModel({
    required this.txLocalInfoModel,
    required this.txRemoteInfoModel,
  });

  SignedTxModel sign(Wallet wallet) {
    CosmosSigner cosmosSigner = CosmosSigner(wallet.ecPrivateKey);

    CosmosAuthInfo cosmosAuthInfo = _getCosmosAuthInfo(wallet.ecPrivateKey.ecPublicKey.compressed);
    CosmosTxBody cosmosTxBody = _getCosmosTxBody();

    CosmosSignDoc cosmosSignDoc = CosmosSignDoc(
      chainId: txRemoteInfoModel.chainId,
      accountNumber: int.parse(txRemoteInfoModel.accountNumber),
      authInfo: cosmosAuthInfo,
      txBody: cosmosTxBody,
    );

    CosmosSignature cosmosSignature = cosmosSigner.signDirect(cosmosSignDoc);
    CosmosTx cosmosTx = CosmosTx.signed(
      body: cosmosTxBody,
      authInfo: cosmosAuthInfo,
      signatures: <CosmosSignature>[cosmosSignature],
    );

    return SignedTxModel(
      txLocalInfoModel: txLocalInfoModel,
      txRemoteInfoModel: txRemoteInfoModel,
      signedCosmosTx: cosmosTx,
    );
  }

  CosmosAuthInfo _getCosmosAuthInfo(Uint8List compressedPublicKey) {
    TokenAmountModel feeTokenAmountModel = txLocalInfoModel.feeTokenAmountModel;
    BigInt feeAmount = feeTokenAmountModel.getAmountInDefaultDenomination().toBigInt();
    String feeDenom = feeTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name;

    CosmosAuthInfo cosmosAuthInfo = CosmosAuthInfo(
      signerInfos: <CosmosSignerInfo>[
        CosmosSignerInfo(
          publicKey: CosmosSimplePublicKey(compressedPublicKey),
          modeInfo: CosmosModeInfo.single(CosmosSignMode.signModeDirect),
          sequence: int.parse(txRemoteInfoModel.sequence),
        ),
      ],
      fee: CosmosFee(
        gasLimit: BigInt.from(20000),
        amount: <CosmosCoin>[
          CosmosCoin(denom: feeDenom, amount: feeAmount),
        ],
      ),
    );

    return cosmosAuthInfo;
  }

  CosmosTxBody _getCosmosTxBody() {
    String memo = txLocalInfoModel.memo;
    List<ProtobufAny> messages = <ProtobufAny>[txLocalInfoModel.txMsgModel.toMsgDto()];

    CosmosTxBody cosmosTxBody = CosmosTxBody(messages: messages, memo: memo);
    return cosmosTxBody;
  }

  @override
  List<Object?> get props => <Object>[txLocalInfoModel, txRemoteInfoModel];
}
