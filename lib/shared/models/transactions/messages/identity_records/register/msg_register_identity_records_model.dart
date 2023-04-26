import 'package:miro/infra/dto/shared/messages/identity_records/register/msg_register_identity_records.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_records/register/identity_info_entry_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class MsgRegisterIdentityRecordsModel extends ATxMsgModel {
  final List<IdentityInfoEntryModel> identityInfoEntryModels;
  final WalletAddress walletAddress;

  const MsgRegisterIdentityRecordsModel({
    required this.identityInfoEntryModels,
    required this.walletAddress,
  }) : super(txMsgType: TxMsgType.msgRegisterIdentityRecords);

  MsgRegisterIdentityRecordsModel.single({
    required this.walletAddress,
    required IdentityInfoEntryModel identityInfoEntryModel,
  })  : identityInfoEntryModels = <IdentityInfoEntryModel>[identityInfoEntryModel],
        super(txMsgType: TxMsgType.msgRegisterIdentityRecords);

  factory MsgRegisterIdentityRecordsModel.fromDto(MsgRegisterIdentityRecords msgRegisterIdentityRecords) {
    return MsgRegisterIdentityRecordsModel(
      identityInfoEntryModels: msgRegisterIdentityRecords.infos.map(IdentityInfoEntryModel.fromDto).toList(),
      walletAddress: WalletAddress.fromBech32(msgRegisterIdentityRecords.address),
    );
  }

  @override
  MsgRegisterIdentityRecords toMsgDto() {
    return MsgRegisterIdentityRecords(
      address: walletAddress.bech32Address,
      infos: identityInfoEntryModels.map((IdentityInfoEntryModel identityInfoEntryModel) => identityInfoEntryModel.toDto()).toList(),
    );
  }

  @override
  List<Object?> get props => <Object>[identityInfoEntryModels, walletAddress];
}
