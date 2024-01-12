import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_undelegate_form_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_undelegate_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';
import 'package:miro/views/widgets/transactions/token_form/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class StakingMsgUndelegateFormPreview extends StatefulWidget {
  final String moniker;
  final StakingMsgUndelegateFormModel stakingMsgUndelegateFormModel;
  final TxLocalInfoModel txLocalInfoModel;
  final WalletAddress validatorWalletAddress;

  StakingMsgUndelegateFormPreview({
    required this.moniker,
    required this.stakingMsgUndelegateFormModel,
    required this.txLocalInfoModel,
    required this.validatorWalletAddress,
    Key? key,
  })  : assert(txLocalInfoModel.txMsgModel is StakingMsgUndelegateModel, 'ITxMsgModel must be an instance of StakingMsgUndelegateModel'),
        super(key: key);

  @override
  State<StakingMsgUndelegateFormPreview> createState() => _StakingMsgUndelegateFormPreviewState();
}

class _StakingMsgUndelegateFormPreviewState extends State<StakingMsgUndelegateFormPreview> {
  late final StakingMsgUndelegateModel msgUndelegateModel = widget.txLocalInfoModel.txMsgModel as StakingMsgUndelegateModel;
  late final TokenAmountModel tokenAmountModel = msgUndelegateModel.tokenAmountModels.first;
  late final TokenAliasModel tokenAliasModel = tokenAmountModel.tokenAliasModel;

  late TokenDenominationModel selectedTokenDenominationModel = widget.stakingMsgUndelegateFormModel.tokenDenominationModel!;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxInputPreview(
          label: S.of(context).txHintUnstakeBy,
          value: msgUndelegateModel.delegatorWalletAddress.bech32Address,
          icon: KiraIdentityAvatar(
            address: msgUndelegateModel.delegatorWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).txHintUnstakeFrom,
          value: widget.moniker,
          icon: KiraIdentityAvatar(
            address: widget.validatorWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).stakingTxTokensToUnstake,
          value: _netAmountText,
          icon: TokenAvatar(
            iconUrl: tokenAmountModel.tokenAliasModel.icon,
            size: 45,
          ),
        ),
        const SizedBox(height: 15),
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TxInputPreview(
                label: S.of(context).txUnstakedLabel,
                labelColor: DesignColors.yellowStatus1,
                value: '${tokenAmountModel.getAmountInNetworkDenomination()} ${tokenAmountModel.tokenAliasModel.networkTokenDenominationModel.name}',
                large: true,
              ),
            ),
            KiraToolTip(
              message: S.of(context).txUnstakedToolTip,
              iconColor: DesignColors.yellowStatus1,
            ),
          ],
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
    TokenAmountModel netTokenAmountModel = tokenAmountModel;
    Decimal netAmount = netTokenAmountModel.getAmountInDenomination(selectedTokenDenominationModel);
    String denominationText = selectedTokenDenominationModel.name;

    String displayedAmount = TxUtils.buildAmountString(netAmount.toString(), selectedTokenDenominationModel);
    return '$displayedAmount $denominationText';
  }

  String get _feeAmountText {
    return widget.txLocalInfoModel.feeTokenAmountModel.toString();
  }

  void _handleTokenDenominationChanged(TokenDenominationModel tokenDenominationModel) {
    widget.stakingMsgUndelegateFormModel.tokenDenominationModel = tokenDenominationModel;
    selectedTokenDenominationModel = tokenDenominationModel;
    setState(() {});
  }
}
