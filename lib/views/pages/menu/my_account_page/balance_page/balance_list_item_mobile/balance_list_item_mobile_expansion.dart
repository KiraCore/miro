import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class BalanceListItemMobileExpansion extends StatelessWidget {
  final TokenAmount tokenAmount;

  const BalanceListItemMobileExpansion({
    required this.tokenAmount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(
      color: DesignColors.white_100,
      fontSize: 16,
    );

    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PrefixedWidget(
            prefix: 'Denomination',
            child: Text(
              tokenAmount.tokenAliasModel.lowestTokenDenomination.name,
              style: textStyle,
            ),
          ),
          const SizedBox(height: 16),
          PrefixedWidget(
            prefix: 'Amount',
            child: Text(
              tokenAmount.getAsDefaultDenomination().toString(),
              style: textStyle.copyWith(color: DesignColors.white_100),
            ),
          ),
        ],
      ),
    );
  }
}
