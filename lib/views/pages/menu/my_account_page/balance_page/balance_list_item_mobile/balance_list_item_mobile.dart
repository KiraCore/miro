import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_builder.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_mobile/balance_list_item_mobile_expansion.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_list_item_mobile/balance_list_item_mobile_title.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_token_prefix.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class BalanceListItemMobile extends StatelessWidget {
  final BalanceModel balanceModel;
  final ExpansionChangedCallback expansionChangedCallback;
  final FavouritePressedCallback favouritePressedCallback;
  final ValueNotifier<bool> hoverNotifier;
  final VoidCallback onSendButtonPressed;

  const BalanceListItemMobile({
    required this.balanceModel,
    required this.expansionChangedCallback,
    required this.favouritePressedCallback,
    required this.hoverNotifier,
    required this.onSendButtonPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ExpansionTile(
          collapsedTextColor: DesignColors.gray2_100,
          collapsedIconColor: DesignColors.gray2_100,
          textColor: DesignColors.gray2_100,
          iconColor: DesignColors.gray2_100,
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
            onPressed: onSendButtonPressed,
            title: 'Send',
          ),
        ),
      ],
    );
  }
}
