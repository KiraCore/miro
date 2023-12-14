import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/staking_msg_claim_undelegation_form_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_claim_undelegation_model.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/views/widgets/kira/kira_identity_avatar.dart';
import 'package:miro/views/widgets/transactions/tx_input_preview.dart';

class StakingMsgClaimUndelegationFormPreview extends StatefulWidget {
  final TokenAmountModel amountToClaim;
  final TxLocalInfoModel txLocalInfoModel;
  final StakingMsgClaimUndelegationFormModel stakingMsgClaimUndelegationFormModel;
  final WalletAddress validatorWalletAddress;

  StakingMsgClaimUndelegationFormPreview({
    required this.amountToClaim,
    required this.txLocalInfoModel,
    required this.stakingMsgClaimUndelegationFormModel,
    required this.validatorWalletAddress,
    Key? key,
  })  : assert(txLocalInfoModel.txMsgModel is StakingMsgClaimUndelegationModel, 'ITxMsgModel must be an instance of StakingMsgClaimUndelegationModel'),
        super(key: key);

  @override
  State<StakingMsgClaimUndelegationFormPreview> createState() => _StakingMsgClaimUndelegationFormPreviewState();
}

class _StakingMsgClaimUndelegationFormPreviewState extends State<StakingMsgClaimUndelegationFormPreview> {
  late final StakingMsgClaimUndelegationModel stakingMsgClaimUndelegationModel = widget.txLocalInfoModel.txMsgModel as StakingMsgClaimUndelegationModel;
  late final TokenAliasModel tokenAliasModel = widget.amountToClaim.tokenAliasModel;

  late TokenDenominationModel selectedTokenDenominationModel = widget.amountToClaim.tokenAliasModel.defaultTokenDenominationModel;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TxInputPreview(
          label: S.of(context).txHintClaimBy,
          value: stakingMsgClaimUndelegationModel.senderWalletAddress.bech32Address,
          icon: KiraIdentityAvatar(
            address: stakingMsgClaimUndelegationModel.senderWalletAddress.bech32Address,
            size: 45,
          ),
        ),
        const SizedBox(height: 16),
        const Divider(color: DesignColors.grey2),
        const SizedBox(height: 15),
        TxInputPreview(
          label: S.of(context).txHintAmountToClaim,
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
      ],
    );
  }

  String get _feeAmountText {
    return widget.txLocalInfoModel.feeTokenAmountModel.toString();
  }

  String get _netAmountText {
    TokenAmountModel netTokenAmountModel = widget.amountToClaim;
    Decimal netAmount = netTokenAmountModel.getAmountInDenomination(selectedTokenDenominationModel);
    String denominationText = selectedTokenDenominationModel.name;

    String displayedAmount = TxUtils.buildAmountString(netAmount.toString(), selectedTokenDenominationModel);
    return '$displayedAmount $denominationText';
  }
}
