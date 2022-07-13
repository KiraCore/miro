import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/views/pages/menu/my_account_page/balance_page/balance_token_prefix.dart';

class BalanceListItemMobileTitle extends StatelessWidget {
  final BalanceModel balanceModel;
  final ValueNotifier<bool> hoverNotifier;
  final FavouritePressedCallback favouritePressedCallback;

  const BalanceListItemMobileTitle({
    required this.balanceModel,
    required this.hoverNotifier,
    required this.favouritePressedCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      color: DesignColors.gray2_100,
      fontSize: 16,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        BalanceTokenPrefix(
          favourite: balanceModel.isFavourite,
          tokenAliasModel: balanceModel.tokenAmount.tokenAliasModel,
          favouriteAlwaysVisible: true,
          favouritePressedCallback: favouritePressedCallback,
          hoverNotifier: hoverNotifier,
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(balanceModel.tokenAmount.tokenAliasModel.defaultTokenDenomination.name, style: textStyle),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                balanceModel.tokenAmount.getAsDefaultDenomination().toString(),
                style: textStyle.copyWith(color: DesignColors.white_100),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
