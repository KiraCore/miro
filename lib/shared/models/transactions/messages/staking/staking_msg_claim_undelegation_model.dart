import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_claim_undelegation.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class StakingMsgClaimUndelegationModel extends ATxMsgModel {
  final WalletAddress senderWalletAddress;
  final String undelegationId;

  const StakingMsgClaimUndelegationModel({
    required this.senderWalletAddress,
    required this.undelegationId,
  }) : super(txMsgType: TxMsgType.msgClaimRewards);

  factory StakingMsgClaimUndelegationModel.fromMsgDto(MsgClaimUndelegation msgClaimUndelegation) {
    return StakingMsgClaimUndelegationModel(
      senderWalletAddress: WalletAddress.fromBech32(msgClaimUndelegation.sender),
      undelegationId: msgClaimUndelegation.undelegationId,
    );
  }

  @override
  ATxMsg toMsgDto() {
    return MsgClaimUndelegation(
      sender: senderWalletAddress.bech32Address,
      undelegationId: undelegationId,
    );
  }

  @override
  List<Object?> get props => <Object>[senderWalletAddress];

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.compare_arrows);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[];
  }

  @override
  String? getSubtitle(TxDirectionType txDirectionType) {
    return senderWalletAddress.bech32Address;
  }

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) {
    return S.of(context).txMsgClaimUndelegation;
  }
}
