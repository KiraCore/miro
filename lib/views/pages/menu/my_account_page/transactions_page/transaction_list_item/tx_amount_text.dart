import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_amount_status_type.dart';
import 'package:miro/shared/models/transactions/list/tx_list_item_model.dart';
import 'package:miro/views/pages/menu/my_account_page/transactions_page/transaction_list_item/prefixed_token_amount_text.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class TxAmountText extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final TxListItemModel txListItemModel;

  const TxAmountText({
    required this.crossAxisAlignment,
    required this.txListItemModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    MainAxisAlignment rowMainAxisAlignment = crossAxisAlignment == CrossAxisAlignment.end ? MainAxisAlignment.end : MainAxisAlignment.start;
    TextAlign textAlign = crossAxisAlignment == CrossAxisAlignment.end ? TextAlign.end : TextAlign.start;

    PrefixedTokenAmountModel? prefixedTokenAmountModel = txListItemModel.prefixedTokenAmounts.isNotEmpty ? txListItemModel.prefixedTokenAmounts.first : null;
    int totalAmountsCount = txListItemModel.prefixedTokenAmounts.length;
    bool feeExistsBool = txListItemModel.isOutbound && txListItemModel.fees.isNotEmpty;
    Color color = prefixedTokenAmountModel?.tokenAmountPrefixType == TokenAmountPrefixType.add ? DesignColors.greenStatus1 : DesignColors.white2;

    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (prefixedTokenAmountModel != null)
          PrefixedTokenAmountText(
            prefixedTokenAmountModel: prefixedTokenAmountModel,
            textAlign: textAlign,
            textStyle: textTheme.bodyText2!.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        if (totalAmountsCount > 1)
          Row(
            mainAxisAlignment: rowMainAxisAlignment,
            children: <Widget>[
              Text(
                S.of(context).txListAmountPlusMore(totalAmountsCount - 1),
                textAlign: TextAlign.right,
                style: textTheme.caption!.copyWith(
                  color: DesignColors.grey1,
                ),
              ),
              KiraToolTip(
                message: txListItemModel.prefixedTokenAmounts.map((PrefixedTokenAmountModel e) => e.toString()).join('\n'),
                childMargin: const EdgeInsets.only(top: 2, bottom: 2, left: 4),
              ),
            ],
          ),
        if (feeExistsBool && prefixedTokenAmountModel != null)
          Row(
            mainAxisAlignment: rowMainAxisAlignment,
            children: <Widget>[
              Text(
                S.of(context).txListAmountPlusFees,
                textAlign: TextAlign.right,
                style: textTheme.caption!.copyWith(
                  color: DesignColors.grey1,
                ),
              ),
              KiraToolTip(
                message: txListItemModel.fees.map((TokenAmountModel e) => e.toString()).join('\n'),
                childMargin: const EdgeInsets.only(top: 2, bottom: 2, left: 4),
              ),
            ],
          )
        else if (feeExistsBool)
          Row(
            mainAxisAlignment: rowMainAxisAlignment,
            children: <Widget>[
              Text(
                S.of(context).txListAmountFeesOnly,
                textAlign: TextAlign.right,
                style: textTheme.bodyText2!.copyWith(
                  color: DesignColors.white2,
                ),
              ),
              const SizedBox(width: 4),
              KiraToolTip(
                message: txListItemModel.fees.map((TokenAmountModel e) => e.toString()).join('\n'),
                childMargin: const EdgeInsets.only(top: 2, bottom: 2, left: 4),
              ),
            ],
          )
      ],
    );
  }
}
