import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/i_tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/register/msg_register_identity_records.dart';
import 'package:miro/shared/models/transactions/messages/i_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/register/identity_info_entry_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class MsgRegisterIdentityRecordsModel extends Equatable implements ITxMsgModel {
  final List<IdentityInfoEntryModel> identityInfoEntryModels;
  final WalletAddress walletAddress;

  const MsgRegisterIdentityRecordsModel({
    required this.identityInfoEntryModels,
    required this.walletAddress,
  });

  MsgRegisterIdentityRecordsModel.single({
    required this.walletAddress,
    required IdentityInfoEntryModel identityInfoEntryModel,
  }) : identityInfoEntryModels = <IdentityInfoEntryModel>[identityInfoEntryModel];

  factory MsgRegisterIdentityRecordsModel.fromDto(MsgRegisterIdentityRecords msgRegisterIdentityRecords) {
    return MsgRegisterIdentityRecordsModel(
      identityInfoEntryModels: msgRegisterIdentityRecords.infos.map(IdentityInfoEntryModel.fromDto).toList(),
      walletAddress: WalletAddress.fromBech32(msgRegisterIdentityRecords.address),
    );
  }

  @override
  ITxMsg toMsgDto() {
    return MsgRegisterIdentityRecords(
      address: walletAddress.bech32Address,
      infos: identityInfoEntryModels.map((IdentityInfoEntryModel identityInfoEntryModel) => identityInfoEntryModel.toDto()).toList(),
    );
  }

  @override
  List<Object?> get props => <Object>[identityInfoEntryModels, walletAddress];
}
