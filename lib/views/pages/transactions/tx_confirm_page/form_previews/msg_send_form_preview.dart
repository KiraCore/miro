import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/tokens/tx_price_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class MsgSendFormPreview extends StatefulWidget {
  final TxLocalInfoModel txLocalInfoModel;
  final TokenDenominationModel? tokenDenominationModel;

  MsgSendFormPreview({
    required this.txLocalInfoModel,
    this.tokenDenominationModel,
    Key? key,
  })  : assert(txLocalInfoModel.txMsgModel is MsgSendModel, 'ITxMsgModel must be an instance of MsgSendModel'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _MsgSendFormPreview();
}

class _MsgSendFormPreview extends State<MsgSendFormPreview> {
  late final MsgSendModel msgSendModel = widget.txLocalInfoModel.txMsgModel as MsgSendModel;
  late final TokenAliasModel tokenAliasModel = msgSendModel.tokenAmountModel.tokenAliasModel;
  late final TxPriceModel txPriceModel = TxPriceModel(
    tokenAmountModel: msgSendModel.tokenAmountModel,
    feeTokenAmountModel: widget.txLocalInfoModel.feeTokenAmountModel,
  );

  late TokenDenominationModel tokenDenominationModel;

  @override
  void initState() {
    super.initState();
    tokenDenominationModel = widget.tokenDenominationModel ?? tokenAliasModel.defaultTokenDenominationModel;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxInputPreview(
          label: 'Send from',
          value: msgSendModel.fromWalletAddress.bech32Address,
          icon: KiraIdentityAvatar(
            address: msgSendModel.fromWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: 'Send to',
          value: msgSendModel.toWalletAddress.bech32Address,
          icon: KiraIdentityAvatar(
            address: msgSendModel.toWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: 'Total amount',
          value: totalAmountText,
          icon: TokenAvatar(
            iconUrl: widget.txLocalInfoModel.feeTokenAmountModel.tokenAliasModel.icon,
            size: 45,
          ),
        ),
        const SizedBox(height: 15),
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 15),
        TxInputPreview(
          label: 'Recipient will get',
          value: netAmountText,
          large: true,
        ),
        const SizedBox(height: 15),
        Text(
          'Transaction fee: $feeAmountText',
          style: textTheme.caption!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 15),
        TokenDenominationList(
          tokenAliasModel: tokenAliasModel,
          defaultTokenDenominationModel: tokenDenominationModel,
          onChanged: (TokenDenominationModel tokenDenominationModel) {
            setState(() {
              this.tokenDenominationModel = tokenDenominationModel;
            });
          },
        ),
        const SizedBox(height: 25),
        TxInputPreview(
          label: 'Memo',
          value: widget.txLocalInfoModel.memo,
        ),
      ],
    );
  }

  String get totalAmountText {
    String amountText = txPriceModel.totalTokenAmountModel.getAmountInDenomination(tokenDenominationModel).toString();
    String denominationText = tokenDenominationModel.name;
    return '$amountText $denominationText';
  }

  String get netAmountText {
    String amountText = txPriceModel.netTokenAmountModel.getAmountInDenomination(tokenDenominationModel).toString();
    String denominationText = tokenDenominationModel.name;
    return '$amountText $denominationText';
  }

  String get feeAmountText {
    return widget.txLocalInfoModel.feeTokenAmountModel.toString();
  }
}
