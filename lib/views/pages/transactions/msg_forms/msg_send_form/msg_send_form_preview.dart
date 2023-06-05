import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/msg_send_form_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class MsgSendFormPreview extends StatefulWidget {
  final MsgSendFormModel msgSendFormModel;
  final TxLocalInfoModel txLocalInfoModel;

  MsgSendFormPreview({
    required this.msgSendFormModel,
    required this.txLocalInfoModel,
    Key? key,
  })  : assert(txLocalInfoModel.txMsgModel is MsgSendModel, 'ITxMsgModel must be an instance of MsgSendModel'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _MsgSendFormPreview();
}

class _MsgSendFormPreview extends State<MsgSendFormPreview> {
  late final MsgSendModel msgSendModel = widget.txLocalInfoModel.txMsgModel as MsgSendModel;
  late final TokenAliasModel tokenAliasModel = msgSendModel.tokenAmountModel.tokenAliasModel;

  late TokenDenominationModel selectedTokenDenominationModel = widget.msgSendFormModel.tokenDenominationModel!;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxInputPreview(
          label: S.of(context).txHintSendFrom,
          value: msgSendModel.fromWalletAddress.bech32Address,
          icon: KiraIdentityAvatar(
            address: msgSendModel.fromWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).txHintSendTo,
          value: msgSendModel.toWalletAddress.bech32Address,
          icon: KiraIdentityAvatar(
            address: msgSendModel.toWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).txTotalAmount,
          value: _totalAmountText,
          icon: TokenAvatar(
            iconUrl: widget.txLocalInfoModel.feeTokenAmountModel.tokenAliasModel.icon,
            size: 45,
          ),
        ),
        const SizedBox(height: 15),
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 15),
        TxInputPreview(
          label: S.of(context).txRecipientWillGet,
          value: _netAmountText,
          large: true,
        ),
        const SizedBox(height: 15),
        Text(
          S.of(context).txNoticeFee(_feeAmountText),
          style: textTheme.caption!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        const SizedBox(height: 15),
        TokenDenominationList(
          tokenAliasModel: tokenAliasModel,
          defaultTokenDenominationModel: selectedTokenDenominationModel,
          onChanged: _handleTokenDenominationChanged,
        ),
        const SizedBox(height: 15),
        TxInputPreview(
          label: S.of(context).txHintMemo,
          value: widget.txLocalInfoModel.memo,
        ),
      ],
    );
  }

  String get _totalAmountText {
    TokenAmountModel totalTokenAmountModel = msgSendModel.tokenAmountModel + widget.txLocalInfoModel.feeTokenAmountModel;
    Decimal totalAmount = totalTokenAmountModel.getAmountInDenomination(selectedTokenDenominationModel);
    String denominationText = selectedTokenDenominationModel.name;
    return '$totalAmount $denominationText';
  }

  String get _netAmountText {
    TokenAmountModel netTokenAmountModel = msgSendModel.tokenAmountModel;
    Decimal netAmount = netTokenAmountModel.getAmountInDenomination(selectedTokenDenominationModel);
    String denominationText = selectedTokenDenominationModel.name;
    return '$netAmount $denominationText';
  }

  String get _feeAmountText {
    return widget.txLocalInfoModel.feeTokenAmountModel.toString();
  }

  void _handleTokenDenominationChanged(TokenDenominationModel tokenDenominationModel) {
    widget.msgSendFormModel.tokenDenominationModel = tokenDenominationModel;
    selectedTokenDenominationModel = tokenDenominationModel;
    setState(() {});
  }
}
