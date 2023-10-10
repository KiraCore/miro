import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_token_prefix.dart';

class BalanceListItemMobileTitle extends StatelessWidget {
  final BalanceModel balanceModel;
  final ValueNotifier<bool> hoverNotifier;
  final ValueChanged<bool> favouritePressedCallback;

  const BalanceListItemMobileTitle({
    required this.balanceModel,
    required this.hoverNotifier,
    required this.favouritePressedCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        BalanceTokenPrefix(
          favourite: balanceModel.isFavourite,
          tokenAliasModel: balanceModel.tokenAmountModel.tokenAliasModel,
          favouriteAlwaysVisible: true,
          favouritePressedCallback: favouritePressedCallback,
          hoverNotifier: hoverNotifier,
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              balanceModel.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
              style: textTheme.bodyLarge!.copyWith(
                color: DesignColors.white1,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                balanceModel.tokenAmountModel.getAmountInDefaultDenomination().toString(),
                style: textTheme.bodyLarge!.copyWith(
                  color: DesignColors.white1,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
