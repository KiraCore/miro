import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_request_verification_form_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_request_verification_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/token_form/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class IRMsgRequestVerificationFormPreview extends StatefulWidget {
  final IRMsgRequestVerificationFormModel irMsgRequestVerificationFormModel;
  final TxLocalInfoModel txLocalInfoModel;

  IRMsgRequestVerificationFormPreview({
    required this.irMsgRequestVerificationFormModel,
    required this.txLocalInfoModel,
    Key? key,
  })  : assert(txLocalInfoModel.txMsgModel is IRMsgRequestVerificationModel, 'ITxMsgModel must be an instance of IRMsgRequestVerificationModel'),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _IRMsgRequestVerificationFormPreview();
}

class _IRMsgRequestVerificationFormPreview extends State<IRMsgRequestVerificationFormPreview> {
  late final IRMsgRequestVerificationModel irMsgRequestVerificationModel = widget.txLocalInfoModel.txMsgModel as IRMsgRequestVerificationModel;
  late final TokenAliasModel tokenAliasModel = irMsgRequestVerificationModel.tipTokenAmountModel.tokenAliasModel;
  late TokenDenominationModel selectedTokenDenominationModel = widget.irMsgRequestVerificationFormModel.tokenDenominationModel!;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxInputPreview(
          label: S.of(context).txHintSendFrom,
          value: widget.irMsgRequestVerificationFormModel.requesterWalletAddress!.bech32Address,
          icon: KiraIdentityAvatar(
            address: widget.irMsgRequestVerificationFormModel.requesterWalletAddress!.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 14),
        TxInputPreview(
          label: S.of(context).txHintSendTo,
          value: widget.irMsgRequestVerificationFormModel.verifierWalletAddress!.bech32Address,
          icon: KiraIdentityAvatar(
            address: widget.irMsgRequestVerificationFormModel.verifierWalletAddress!.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).irTxHintKey,
          value: widget.irMsgRequestVerificationFormModel.irRecordModel.key,
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).irTxHintValue,
          value: widget.irMsgRequestVerificationFormModel.irRecordModel.value ?? '',
        ),
        const SizedBox(height: 15),
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 15),
        TxInputPreview(
          label: S.of(context).irTxHintVerifierWillGet,
          value: _netAmountText,
          large: true,
        ),
        const SizedBox(height: 15),
        Text(
          S.of(context).txNoticeFee(_feeAmountText),
          style: textTheme.bodySmall!.copyWith(
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

  String get _netAmountText {
    TokenAmountModel netTokenAmountModel = widget.irMsgRequestVerificationFormModel.tipTokenAmountModel!;
    Decimal netAmount = netTokenAmountModel.getAmountInDenomination(selectedTokenDenominationModel);
    String denominationName = selectedTokenDenominationModel.name;
    return '$netAmount $denominationName';
  }

  String get _feeAmountText {
    return widget.txLocalInfoModel.feeTokenAmountModel.toString();
  }

  void _handleTokenDenominationChanged(TokenDenominationModel tokenDenominationModel) {
    widget.irMsgRequestVerificationFormModel.tokenDenominationModel = tokenDenominationModel;
    selectedTokenDenominationModel = tokenDenominationModel;
    setState(() {});
  }
}
