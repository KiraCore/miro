import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_delegate_form_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_delegate_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/token_form/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class StakingMsgDelegateFormPreview extends StatefulWidget {
  final StakingMsgDelegateFormModel stakingMsgDelegateFormModel;
  final TxLocalInfoModel txLocalInfoModel;

  StakingMsgDelegateFormPreview({
    required this.stakingMsgDelegateFormModel,
    required this.txLocalInfoModel,
    Key? key,
  })  : assert(txLocalInfoModel.txMsgModel is StakingMsgDelegateModel, 'ITxMsgModel must be an instance of MsgDelegateModel'),
        super(key: key);

  @override
  State<StakingMsgDelegateFormPreview> createState() => _StakingMsgDelegateFormPreviewState();
}

class _StakingMsgDelegateFormPreviewState extends State<StakingMsgDelegateFormPreview> {
  late final StakingMsgDelegateModel msgDelegateModel = widget.txLocalInfoModel.txMsgModel as StakingMsgDelegateModel;
  late final TokenAmountModel tokenAmountModel = msgDelegateModel.tokenAmountModels.first;
  late final TokenAliasModel tokenAliasModel = tokenAmountModel.tokenAliasModel;

  late TokenDenominationModel selectedTokenDenominationModel = widget.stakingMsgDelegateFormModel.tokenDenominationModel!;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxInputPreview(
          label: S.of(context).txHintSendFrom,
          value: msgDelegateModel.delegatorWalletAddress.bech32Address,
          icon: KiraIdentityAvatar(
            address: msgDelegateModel.delegatorWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).txHintSendTo,
          value: msgDelegateModel.valoperWalletAddress.bech32Address,
          icon: KiraIdentityAvatar(
            address: msgDelegateModel.valoperWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).stakingTxTokensToDelegate,
          value: '${tokenAmountModel.getAmountInDefaultDenomination()} ${tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name}',
          icon: TokenAvatar(
            iconUrl: tokenAmountModel.tokenAliasModel.icon,
            size: 45,
          ),
        ),
        const SizedBox(height: 15),
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 15),
        Text(
          S.of(context).txRecipientWillGet,
          style: textTheme.bodyText2!.copyWith(
            color: DesignColors.white1,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: DesignColors.background,
            border: Border.all(color: DesignColors.greyOutline),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GridView.count(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 5 / 1,
            children: <Widget>[
              for (TokenAmountModel tokenAmountModel in msgDelegateModel.tokenAmountModels)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TokenAvatar(
                        iconUrl: tokenAmountModel.tokenAliasModel.icon,
                        size: 40,
                      ),
                      const SizedBox(width: 12),
                      Text('${tokenAmountModel.getAmountInDefaultDenomination()} ${tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name}',
                          style: Theme.of(context).textTheme.bodyText1),
                    ],
                  ),
                ),
            ],
          ),
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

  String get _feeAmountText {
    return widget.txLocalInfoModel.feeTokenAmountModel.toString();
  }

  void _handleTokenDenominationChanged(TokenDenominationModel tokenDenominationModel) {
    widget.stakingMsgDelegateFormModel.tokenDenominationModel = tokenDenominationModel;
    selectedTokenDenominationModel = tokenDenominationModel;
    setState(() {});
  }
}
