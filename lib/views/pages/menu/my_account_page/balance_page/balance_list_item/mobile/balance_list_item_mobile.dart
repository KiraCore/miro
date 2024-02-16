import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item/mobile/balance_list_item_mobile_expansion.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item/mobile/balance_list_item_mobile_title.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class BalanceListItemMobile extends StatelessWidget {
  final BalanceModel balanceModel;
  final ValueChanged<bool> expansionChangedCallback;
  final ValueChanged<bool> favouritePressedCallback;
  final ValueNotifier<bool> hoverNotifier;
  final VoidCallback onSendButtonPressed;
  final bool sendButtonActiveBool;

  const BalanceListItemMobile({
    required this.balanceModel,
    required this.expansionChangedCallback,
    required this.favouritePressedCallback,
    required this.hoverNotifier,
    required this.onSendButtonPressed,
    required this.sendButtonActiveBool,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ExpansionTile(
          collapsedTextColor: DesignColors.white1,
          collapsedIconColor: DesignColors.white1,
          textColor: DesignColors.white1,
          iconColor: DesignColors.white1,
          onExpansionChanged: expansionChangedCallback,
          controlAffinity: ListTileControlAffinity.trailing,
          tilePadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          title: BalanceListItemMobileTitle(
            balanceModel: balanceModel,
            hoverNotifier: hoverNotifier,
            favouritePressedCallback: favouritePressedCallback,
          ),
          children: <Widget>[
            BalanceListItemMobileExpansion(
              tokenAmountModel: balanceModel.tokenAmountModel,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
          child: KiraOutlinedButton(
            height: 40,
            width: double.infinity,
            disabled: sendButtonActiveBool == false,
            onPressed: sendButtonActiveBool ? onSendButtonPressed : null,
            title: S.of(context).balancesSend,
          ),
        ),
      ],
    );
  }
}
