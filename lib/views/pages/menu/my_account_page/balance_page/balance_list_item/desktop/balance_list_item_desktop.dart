import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item/desktop/balance_list_item_desktop_expansion.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item/desktop/balance_list_item_desktop_title.dart';

class BalanceListItemDesktop extends StatelessWidget {
  final BalanceModel balanceModel;
  final ValueChanged<bool> expansionChangedCallback;
  final ValueChanged<bool> favouritePressedCallback;
  final ValueNotifier<bool> hoverNotifier;
  final VoidCallback onSendButtonPressed;
  final double sectionsSpace;
  final bool sendButtonActiveBool;

  const BalanceListItemDesktop({
    required this.balanceModel,
    required this.expansionChangedCallback,
    required this.favouritePressedCallback,
    required this.hoverNotifier,
    required this.onSendButtonPressed,
    required this.sendButtonActiveBool,
    this.sectionsSpace = 15,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedTextColor: DesignColors.white1,
      collapsedIconColor: DesignColors.white1,
      textColor: DesignColors.white1,
      iconColor: DesignColors.white1,
      onExpansionChanged: expansionChangedCallback,
      controlAffinity: ListTileControlAffinity.leading,
      tilePadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      childrenPadding: const EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 8),
      title: BalanceListItemDesktopTitle(
        balanceModel: balanceModel,
        hoverNotifier: hoverNotifier,
        favouritePressedCallback: favouritePressedCallback,
        onSendButtonPressed: onSendButtonPressed,
        sendButtonActiveBool: sendButtonActiveBool,
        sectionsSpace: sectionsSpace,
      ),
      children: <Widget>[
        BalanceListItemDesktopExpansion(
          tokenAmountModel: balanceModel.tokenAmountModel,
          sectionsSpace: sectionsSpace,
        ),
      ],
    );
  }
}
