import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_delegate_form_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_delegate_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/token_form/token_denomination_list.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class StakingMsgDelegateFormPreview extends StatefulWidget {
  final String moniker;
  final StakingMsgDelegateFormModel stakingMsgDelegateFormModel;
  final TxLocalInfoModel txLocalInfoModel;
  final WalletAddress validatorWalletAddress;

  StakingMsgDelegateFormPreview({
    required this.moniker,
    required this.stakingMsgDelegateFormModel,
    required this.txLocalInfoModel,
    required this.validatorWalletAddress,
    Key? key,
  })  : assert(txLocalInfoModel.txMsgModel is StakingMsgDelegateModel, 'ITxMsgModel must be an instance of StakingMsgDelegateModel'),
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
          label: S.of(context).txHintStakeBy,
          value: msgDelegateModel.delegatorWalletAddress.bech32Address,
          icon: KiraIdentityAvatar(
            address: msgDelegateModel.delegatorWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).txHintStakeOn,
          value: widget.moniker,
          icon: KiraIdentityAvatar(
            address: widget.validatorWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 28),
        TxInputPreview(
          label: S.of(context).stakingTxTokensToStake,
          value: _netAmountText,
          icon: TokenAvatar(
            iconUrl: tokenAmountModel.tokenAliasModel.icon,
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
    widget.stakingMsgDelegateFormModel.tokenDenominationModel = tokenDenominationModel;
    selectedTokenDenominationModel = tokenDenominationModel;
    setState(() {});
  }
}
