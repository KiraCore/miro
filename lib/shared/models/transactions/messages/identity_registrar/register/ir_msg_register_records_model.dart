part of '../../a_tx_msg_model.dart';

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
      walletAddress: WalletAddress.fromBech32(msgRegisterIdentityRecords.address.value),
    );
  }

  @override
  MsgRegisterIdentityRecords toMsgDto() {
    return MsgRegisterIdentityRecords(
      address: CosmosAccAddress(walletAddress.bech32Address),
      infos: irEntryModels.map((IREntryModel irEntryModel) => irEntryModel.toDto()).toList(),
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.app_registration);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[];
  }

  @override
  String getSubtitle(TxDirectionType txDirectionType) => irEntryModels.map((IREntryModel e) => e.key).join(', ');

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) => S.of(context).txMsgRegisterIdentityRecords;

  @override
  List<Object?> get props => <Object>[irEntryModels, walletAddress];
}
