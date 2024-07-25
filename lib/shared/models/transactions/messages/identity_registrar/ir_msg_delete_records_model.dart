import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_delete_identity_records.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class IRMsgDeleteRecordsModel extends ATxMsgModel {
  final List<String> keys;
  final WalletAddress walletAddress;

  const IRMsgDeleteRecordsModel({
    required this.keys,
    required this.walletAddress,
  }) : super(txMsgType: TxMsgType.msgDeleteIdentityRecords);

  IRMsgDeleteRecordsModel.single({
    required String key,
    required this.walletAddress,
  })  : keys = <String>[key],
        super(txMsgType: TxMsgType.msgDeleteIdentityRecords);

  factory IRMsgDeleteRecordsModel.fromDto(MsgDeleteIdentityRecords msgDeleteIdentityRecords) {
    return IRMsgDeleteRecordsModel(
      keys: msgDeleteIdentityRecords.keys,
      walletAddress: WalletAddress.fromBech32(msgDeleteIdentityRecords.address.value),
    );
  }

  @override
  MsgDeleteIdentityRecords toMsgDto() {
    return MsgDeleteIdentityRecords(
      keys: keys,
      address: CosmosAccAddress(walletAddress.bech32Address),
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.delete_outline);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[];
  }

  @override
  String getSubtitle(TxDirectionType txDirectionType) => keys.join(', ');

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) => S.of(context).txMsgDeleteIdentityRecords;

  @override
  List<Object?> get props => <Object>[keys, walletAddress];
}
