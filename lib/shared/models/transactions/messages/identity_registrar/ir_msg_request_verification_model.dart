import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_request_identity_records_verify.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class IRMsgRequestVerificationModel extends ATxMsgModel {
  final List<BigInt> recordIds;
  final TokenAmountModel tipTokenAmountModel;
  final WalletAddress verifierWalletAddress;
  final WalletAddress walletAddress;

  const IRMsgRequestVerificationModel({
    required this.recordIds,
    required this.tipTokenAmountModel,
    required this.verifierWalletAddress,
    required this.walletAddress,
  }) : super(txMsgType: TxMsgType.msgRequestIdentityRecordsVerify);

  IRMsgRequestVerificationModel.single({
    required BigInt recordId,
    required this.tipTokenAmountModel,
    required this.verifierWalletAddress,
    required this.walletAddress,
  })  : recordIds = <BigInt>[recordId],
        super(txMsgType: TxMsgType.msgRequestIdentityRecordsVerify);

  factory IRMsgRequestVerificationModel.fromDto(MsgRequestIdentityRecordsVerify msgRequestIdentityRecordsVerify) {
    return IRMsgRequestVerificationModel(
      recordIds: msgRequestIdentityRecordsVerify.recordIds,
      tipTokenAmountModel: TokenAmountModel(
        defaultDenominationAmount: Decimal.parse(msgRequestIdentityRecordsVerify.tip.amount),
        tokenAliasModel: TokenAliasModel.local(msgRequestIdentityRecordsVerify.tip.denom),
      ),
      verifierWalletAddress: WalletAddress.fromBech32(msgRequestIdentityRecordsVerify.verifier),
      walletAddress: WalletAddress.fromBech32(msgRequestIdentityRecordsVerify.address),
    );
  }

  @override
  MsgRequestIdentityRecordsVerify toMsgDto() {
    return MsgRequestIdentityRecordsVerify(
      address: walletAddress.bech32Address,
      recordIds: recordIds,
      tip: Coin.fromTokenAmountModel(tipTokenAmountModel),
      verifier: verifierWalletAddress.bech32Address,
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
  String getSubtitle(TxDirectionType txDirectionType) => verifierWalletAddress.bech32Address;

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) => S.of(context).txMsgRequestIdentityRecordsVerify;

  @override
  List<Object?> get props => <Object>[recordIds, tipTokenAmountModel, verifierWalletAddress, walletAddress];
}
