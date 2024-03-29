import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_token_prefix.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class BalanceListItemDesktopTitle extends StatelessWidget {
  final double sectionsSpace;
  final BalanceModel balanceModel;
  final ValueChanged<bool> favouritePressedCallback;
  final ValueNotifier<bool> hoverNotifier;
  final VoidCallback onSendButtonPressed;
  final bool sendButtonActiveBool;

  const BalanceListItemDesktopTitle({
    required this.sectionsSpace,
    required this.balanceModel,
    required this.favouritePressedCallback,
    required this.hoverNotifier,
    required this.onSendButtonPressed,
    required this.sendButtonActiveBool,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: BalanceTokenPrefix(
            favourite: balanceModel.isFavourite,
            tokenAliasModel: balanceModel.tokenAmountModel.tokenAliasModel,
            favouriteAlwaysVisible: false,
            favouritePressedCallback: favouritePressedCallback,
            hoverNotifier: hoverNotifier,
          ),
        ),
        SizedBox(width: sectionsSpace),
        Expanded(
          child: Text(
            balanceModel.tokenAmountModel.tokenAliasModel.networkTokenDenominationModel.name,
            style: textTheme.bodyLarge!.copyWith(
              color: DesignColors.white2,
            ),
          ),
        ),
        SizedBox(width: sectionsSpace),
        Expanded(
          flex: 2,
          child: Text(
            balanceModel.tokenAmountModel.getAmountInNetworkDenomination().toString(),
            style: textTheme.titleMedium!.copyWith(
              color: DesignColors.white1,
            ),
          ),
        ),
        SizedBox(width: sectionsSpace),
        KiraOutlinedButton(
          height: 40,
          width: 70,
          disabled: sendButtonActiveBool == false,
          onPressed: sendButtonActiveBool ? onSendButtonPressed : null,
          title: S.of(context).balancesSend,
        ),
      ],
    );
  }
}
