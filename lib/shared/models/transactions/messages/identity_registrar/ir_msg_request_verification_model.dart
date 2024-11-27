part of '../a_tx_msg_model.dart';

class IRMsgRequestVerificationModel extends ATxMsgModel {
  final List<int> recordIds;
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
      verifierWalletAddress: WalletAddress.fromBech32(msgRequestIdentityRecordsVerify.verifier.value),
      walletAddress: WalletAddress.fromBech32(msgRequestIdentityRecordsVerify.address.value),
    );
  }

  @override
  MsgRequestIdentityRecordsVerify toMsgDto() {
    return MsgRequestIdentityRecordsVerify(
      address: CosmosAccAddress(walletAddress.bech32Address),
      verifier: CosmosAccAddress(verifierWalletAddress.bech32Address),
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
  String getSubtitle(TxDirectionType txDirectionType) => verifierWalletAddress.bech32Address;

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) => S.of(context).txMsgRequestIdentityRecordsVerify;

  @override
  WalletAddress get fromAddress => walletAddress;

  @override
  WalletAddress get toAddress => verifierWalletAddress;

  @override
  List<Object?> get props => <Object>[recordIds, tipTokenAmountModel, verifierWalletAddress, walletAddress];
}
