import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/views/widgets/generic/prefixed_widget.dart';

class BalanceListItemDesktopExpansion extends StatelessWidget {
  final TokenAmountModel tokenAmountModel;
  final double sectionsSpace;

  const BalanceListItemDesktopExpansion({
    required this.tokenAmountModel,
    required this.sectionsSpace,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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
            prefix: S.of(context).balancesDenomination,
            child: Text(
              tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
              style: textTheme.titleMedium!.copyWith(
                color: DesignColors.white2,
              ),
            ),
          ),
        ),
        SizedBox(width: sectionsSpace),
        Expanded(
          flex: 2,
          child: PrefixedWidget(
            prefix: S.of(context).balancesAmount,
            child: Text(
              tokenAmountModel.getAmountInDefaultDenomination().toString(),
              style: textTheme.titleMedium!.copyWith(
                color: DesignColors.white2,
              ),
            ),
          ),
        ),
        SizedBox(width: sectionsSpace),
        const SizedBox(width: 70),
      ],
    );
  }
}
