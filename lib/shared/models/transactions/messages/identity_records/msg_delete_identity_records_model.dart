import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/i_tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/msg_delete_identity_records.dart';
import 'package:miro/shared/models/transactions/messages/i_tx_msg_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class MsgDeleteIdentityRecordsModel extends Equatable implements ITxMsgModel {
  final List<String> keys;
  final WalletAddress walletAddress;

  const MsgDeleteIdentityRecordsModel({
    required this.keys,
    required this.walletAddress,
  });

  MsgDeleteIdentityRecordsModel.single({
    required String key,
    required this.walletAddress,
  }) : keys = <String>[key];

  factory MsgDeleteIdentityRecordsModel.fromDto(MsgDeleteIdentityRecords msgDeleteIdentityRecords) {
    return MsgDeleteIdentityRecordsModel(
        keys: msgDeleteIdentityRecords.keys, walletAddress: WalletAddress.fromBech32(msgDeleteIdentityRecords.address));
  }

  @override
  ITxMsg toMsgDto() {
    return MsgDeleteIdentityRecords(
      keys: keys,
      address: walletAddress.bech32Address,
    );
  }

  @override
  List<Object?> get props => <Object>[keys, walletAddress];
}
