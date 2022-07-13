import 'package:flutter/cupertino.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class BalanceListItemMobileExpansion extends StatelessWidget {
  final TokenAmountModel tokenAmountModel;

  const BalanceListItemMobileExpansion({
    required this.tokenAmountModel,
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
              tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name,
              style: textStyle,
            ),
          ),
          const SizedBox(height: 16),
          PrefixedWidget(
            prefix: 'Amount',
            child: Text(
              tokenAmountModel.getAmountInDefaultDenomination().toString(),
              style: textStyle.copyWith(color: DesignColors.white_100),
            ),
          ),
        ],
      ),
    );
  }
}
