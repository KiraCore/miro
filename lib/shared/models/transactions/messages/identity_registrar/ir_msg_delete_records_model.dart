import 'package:miro/infra/dto/shared/messages/identity_records/msg_delete_identity_records.dart';
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
      walletAddress: WalletAddress.fromBech32(msgDeleteIdentityRecords.address),
    );
  }

  @override
  MsgDeleteIdentityRecords toMsgDto() {
    return MsgDeleteIdentityRecords(
      keys: keys,
      address: walletAddress.bech32Address,
    );
  }

  @override
  List<Object?> get props => <Object>[keys, walletAddress];
}
