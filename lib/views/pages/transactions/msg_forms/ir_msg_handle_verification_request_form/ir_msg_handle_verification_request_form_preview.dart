import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_handle_verification_request_form_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_handle_verification_request_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/token_form/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class IRMsgHandleVerificationRequestFormPreview extends StatefulWidget {
  final IRMsgHandleVerificationRequestFormModel irMsgHandleVerificationRequestFormModel;
  final TxLocalInfoModel txLocalInfoModel;

  IRMsgHandleVerificationRequestFormPreview({
    required this.irMsgHandleVerificationRequestFormModel,
    required this.txLocalInfoModel,
    Key? key,
  })  : assert(
          txLocalInfoModel.txMsgModel is IRMsgHandleVerificationRequestModel,
          'ITxMsgModel must be an instance of IRMsgHandleVerificationRequestModel',
        ),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _IRMsgHandleVerificationRequestFormPreview();
}

class _IRMsgHandleVerificationRequestFormPreview extends State<IRMsgHandleVerificationRequestFormPreview> {
  late final IRMsgHandleVerificationRequestModel irMsgHandleVerificationRequestModel =
      widget.txLocalInfoModel.txMsgModel as IRMsgHandleVerificationRequestModel;
  late final IRInboundVerificationRequestModel irInboundVerificationRequestModel =
      widget.irMsgHandleVerificationRequestFormModel.irInboundVerificationRequestModel;
  late final TokenAliasModel tokenAliasModel = irInboundVerificationRequestModel.tipTokenAmountModel.tokenAliasModel;
  late TokenDenominationModel selectedTokenDenominationModel = tokenAliasModel.networkTokenDenominationModel;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final IRUserProfileModel requesterIrUserProfileModel = irInboundVerificationRequestModel.requesterIrUserProfileModel;
    final Map<String, String> records = irInboundVerificationRequestModel.records;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxInputPreview(
          label: S.of(context).txHintSendFrom,
          value: irMsgHandleVerificationRequestModel.walletAddress.address,
          icon: KiraIdentityAvatar(
            address: irMsgHandleVerificationRequestModel.walletAddress.address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).txHintSendTo,
          value: requesterIrUserProfileModel.walletAddress.address,
          icon: KiraIdentityAvatar(
            address: requesterIrUserProfileModel.walletAddress.address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).irTxHintTip,
          value: widget.irMsgHandleVerificationRequestFormModel.irInboundVerificationRequestModel.tipTokenAmountModel.toString(),
          icon: TokenAvatar(size: 45),
        ),
        const SizedBox(height: 28),
        PrefixedWidget(
          prefix: irMsgHandleVerificationRequestModel.approvalStatusBool
              ? records.keys.length > 1
                  ? S.of(context).irVerificationRequestsApprovedRecords
                  : S.of(context).irVerificationRequestsApprovedRecord
              : records.keys.length > 1
                  ? S.of(context).irVerificationRequestsRejectedRecords
                  : S.of(context).irVerificationRequestsRejectedRecord,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 8),
              for (String key in records.keys)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: DesignColors.grey2, width: 1),
                    borderRadius: BorderRadius.circular(8),
                    color: DesignColors.background,
                  ),
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    children: <Widget>[
                      TxInputPreview(
                        label: S.of(context).irTxHintKey,
                        value: key,
                      ),
                      const SizedBox(height: 28),
                      TxInputPreview(
                        label: S.of(context).irTxHintValue,
                        value: records[key] ?? '',
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        TxInputPreview(
          label: S.of(context).txYouWillGet,
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
        const SizedBox(height: 30),
      ],
    );
  }

  String get _netAmountText {
    TokenAmountModel feeTokenAmountModel = widget.txLocalInfoModel.feeTokenAmountModel;
    TokenAmountModel tipTokenAmountModel = irInboundVerificationRequestModel.tipTokenAmountModel;
    if (feeTokenAmountModel.tokenAliasModel == tipTokenAmountModel.tokenAliasModel) {
      tipTokenAmountModel = tipTokenAmountModel - feeTokenAmountModel;
    }
    Decimal netAmount = tipTokenAmountModel.getAmountInDenomination(selectedTokenDenominationModel);
    String denominationText = selectedTokenDenominationModel.name;

    String displayedAmount = TxUtils.buildAmountString(netAmount.toString(), selectedTokenDenominationModel);
    return '$displayedAmount $denominationText';
  }

  String get _feeAmountText {
    return widget.txLocalInfoModel.feeTokenAmountModel.toString();
  }

  void _handleTokenDenominationChanged(TokenDenominationModel tokenDenominationModel) {
    selectedTokenDenominationModel = tokenDenominationModel;
    setState(() {});
  }
}
