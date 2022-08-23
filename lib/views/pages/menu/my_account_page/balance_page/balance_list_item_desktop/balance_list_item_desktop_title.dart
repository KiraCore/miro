import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_token_prefix.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class BalanceListItemDesktopTitle extends StatelessWidget {
  final BalanceModel balanceModel;
  final ValueNotifier<bool> hoverNotifier;
  final FavouritePressedCallback favouritePressedCallback;
  final double sectionsSpace;

  const BalanceListItemDesktopTitle({
    required this.balanceModel,
    required this.hoverNotifier,
    required this.favouritePressedCallback,
    required this.sectionsSpace,
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
            balanceModel.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
            style: textTheme.bodyText1!.copyWith(
              color: DesignColors.gray2_100,
            ),
          ),
        ),
        SizedBox(width: sectionsSpace),
        Expanded(
          flex: 2,
          child: Text(
            balanceModel.tokenAmountModel.getAmountInDefaultDenomination().toString(),
            style: textTheme.subtitle1!.copyWith(
              color: DesignColors.white_100,
            ),
          ),
        ),
        SizedBox(width: sectionsSpace),
        KiraOutlinedButton(
          height: 40,
          width: 70,
          onPressed: () {},
          title: 'Send',
        ),
      ],
    );
  }
}
