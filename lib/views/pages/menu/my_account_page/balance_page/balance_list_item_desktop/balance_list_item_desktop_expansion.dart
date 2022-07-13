import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class BalanceListItemDesktopExpansion extends StatelessWidget {
  final TokenAmount tokenAmount;
  final double sectionsSpace;

  const BalanceListItemDesktopExpansion({
    required this.tokenAmount,
    required this.sectionsSpace,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
          color: DesignColors.white_100,
          fontSize: 16,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Expansion arrow space
        const SizedBox(width: 50),
        const Spacer(),
        SizedBox(width: sectionsSpace),
        Expanded(
          child: PrefixedWidget(
            prefix: 'Denomination',
            child: Text(
              tokenAmount.tokenAliasModel.lowestTokenDenomination.name,
              style: textStyle,
            ),
          ),
        ),
        SizedBox(width: sectionsSpace),
        Expanded(
          flex: 2,
          child: PrefixedWidget(
            prefix: 'Amount',
            child: Text(
              tokenAmount.getAsLowestDenomination().toString(),
              style: textStyle,
            ),
          ),
        ),
        SizedBox(width: sectionsSpace),
        const SizedBox(
          width: 70,
        ),
      ],
    );
  }
}
