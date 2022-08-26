import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_desktop/balance_list_item_desktop_expansion.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_desktop/balance_list_item_desktop_title.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_token_prefix.dart';

class BalanceListItemDesktop extends StatelessWidget {
  final BalanceModel balanceModel;
  final ExpansionChangedCallback expansionChangedCallback;
  final FavouritePressedCallback favouritePressedCallback;
  final ValueNotifier<bool> hoverNotifier;
  final VoidCallback onSendButtonPressed;
  final double sectionsSpace;

  const BalanceListItemDesktop({
    required this.balanceModel,
    required this.expansionChangedCallback,
    required this.favouritePressedCallback,
    required this.hoverNotifier,
    required this.onSendButtonPressed,
    this.sectionsSpace = 15,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedTextColor: DesignColors.gray2_100,
      collapsedIconColor: DesignColors.gray2_100,
      textColor: DesignColors.gray2_100,
      iconColor: DesignColors.gray2_100,
      onExpansionChanged: expansionChangedCallback,
      controlAffinity: ListTileControlAffinity.leading,
      tilePadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
      childrenPadding: const EdgeInsets.only(left: 25, right: 25, bottom: 20, top: 8),
      title: BalanceListItemDesktopTitle(
        balanceModel: balanceModel,
        hoverNotifier: hoverNotifier,
        favouritePressedCallback: favouritePressedCallback,
        onSendButtonPressed: onSendButtonPressed,
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
