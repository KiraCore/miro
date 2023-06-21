import 'package:miro/infra/dto/shared/messages/identity_records/register/msg_register_identity_records.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_entry_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class IRMsgRegisterRecordsModel extends ATxMsgModel {
  final List<IREntryModel> irEntryModels;
  final WalletAddress walletAddress;

  const IRMsgRegisterRecordsModel({
    required this.irEntryModels,
    required this.walletAddress,
  }) : super(txMsgType: TxMsgType.msgRegisterIdentityRecords);

  IRMsgRegisterRecordsModel.single({
    required this.walletAddress,
    required IREntryModel irEntryModel,
  })  : irEntryModels = <IREntryModel>[irEntryModel],
        super(txMsgType: TxMsgType.msgRegisterIdentityRecords);

  factory IRMsgRegisterRecordsModel.fromDto(MsgRegisterIdentityRecords msgRegisterIdentityRecords) {
    return IRMsgRegisterRecordsModel(
      irEntryModels: msgRegisterIdentityRecords.infos.map(IREntryModel.fromDto).toList(),
      walletAddress: WalletAddress.fromBech32(msgRegisterIdentityRecords.address),
    );
  }

  @override
  MsgRegisterIdentityRecords toMsgDto() {
    return MsgRegisterIdentityRecords(
      address: walletAddress.bech32Address,
      infos: irEntryModels.map((IREntryModel irEntryModel) => irEntryModel.toDto()).toList(),
    );
  }

  @override
  List<Object?> get props => <Object>[irEntryModels, walletAddress];
}
