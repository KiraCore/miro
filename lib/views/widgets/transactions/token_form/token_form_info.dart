import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TokenFormInfo extends StatelessWidget {
  final TokenAmountModel feeTokenAmountModel;
  final FormFieldState<TokenAmountModel> formFieldState;
  final BalanceModel? balanceModel;
  final TokenDenominationModel? tokenDenominationModel;

  const TokenFormInfo({
    required this.feeTokenAmountModel,
    required this.formFieldState,
    this.balanceModel,
    this.tokenDenominationModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    if (tokenDenominationModel == null || balanceModel == null) {
      return const SizedBox();
    }
    TokenAmountModel availableTokenAmountModel = balanceModel!.tokenAmountModel - feeTokenAmountModel;
    String availableAmountText = availableTokenAmountModel.getAmountInDenomination(tokenDenominationModel!).toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 7),
        if (formFieldState.hasError) ...<Widget>[
          Text(
            formFieldState.errorText!,
            style: textTheme.caption!.copyWith(
              color: DesignColors.redStatus1,
            ),
          ),
        ],
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 7),
            Text(
              S.of(context).txAvailableBalances(availableAmountText, tokenDenominationModel!.name),
              style: textTheme.caption!.copyWith(
                color: formFieldState.hasError ? DesignColors.redStatus1 : DesignColors.white2,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ],
    );
  }
}
