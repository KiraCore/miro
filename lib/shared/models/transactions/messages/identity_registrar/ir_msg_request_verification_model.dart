import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_request_identity_records_verify.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class IRMsgRequestVerificationModel extends ATxMsgModel {
  final List<int> recordIds;
  final TokenAmountModel tipTokenAmountModel;
  final AWalletAddress verifierWalletAddress;
  final AWalletAddress walletAddress;

  const IRMsgRequestVerificationModel({
    required this.recordIds,
    required this.tipTokenAmountModel,
    required this.verifierWalletAddress,
    required this.walletAddress,
  }) : super(txMsgType: TxMsgType.msgRequestIdentityRecordsVerify);

  IRMsgRequestVerificationModel.single({
    required int recordId,
    required this.tipTokenAmountModel,
    required this.verifierWalletAddress,
    required this.walletAddress,
  })  : recordIds = <int>[recordId],
        super(txMsgType: TxMsgType.msgRequestIdentityRecordsVerify);

  factory IRMsgRequestVerificationModel.fromDto(MsgRequestIdentityRecordsVerify msgRequestIdentityRecordsVerify) {
    return IRMsgRequestVerificationModel(
      recordIds: msgRequestIdentityRecordsVerify.recordIds,
      tipTokenAmountModel: TokenAmountModel(
        defaultDenominationAmount: Decimal.fromBigInt(msgRequestIdentityRecordsVerify.tip.amount),
        tokenAliasModel: TokenAliasModel.local(msgRequestIdentityRecordsVerify.tip.denom),
      ),
      verifierWalletAddress: AWalletAddress.fromAddress(msgRequestIdentityRecordsVerify.verifier.value),
      walletAddress: AWalletAddress.fromAddress(msgRequestIdentityRecordsVerify.address.value),
    );
  }

  @override
  MsgRequestIdentityRecordsVerify toMsgDto() {
    return MsgRequestIdentityRecordsVerify(
      address: CosmosAccAddress(walletAddress.address),
      verifier: CosmosAccAddress(verifierWalletAddress.address),
      recordIds: recordIds,
      tip: CosmosCoin(
        denom: tipTokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
        amount: tipTokenAmountModel.getAmountInDefaultDenomination().toBigInt(),
      ),
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.supervisor_account_outlined);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[
      PrefixedTokenAmountModel(
        tokenAmountModel: tipTokenAmountModel,
        tokenAmountPrefixType: txDirectionType == TxDirectionType.outbound ? TokenAmountPrefixType.subtract : TokenAmountPrefixType.add,
      ),
    ];
  }

  @override
  String getSubtitle(TxDirectionType txDirectionType) => verifierWalletAddress.address;

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) => S.of(context).txMsgRequestIdentityRecordsVerify;

  @override
  List<Object?> get props => <Object>[recordIds, tipTokenAmountModel, verifierWalletAddress, walletAddress];
}
