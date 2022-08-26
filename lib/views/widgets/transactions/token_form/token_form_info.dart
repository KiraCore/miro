import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/balances/total_balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TokenFormInfo extends StatelessWidget {
  final FormFieldState<TokenAmountModel> formFieldState;
  final ValueNotifier<TokenDenominationModel?> tokenDenominationModelNotifier;
  final TotalBalanceModel? totalBalanceModel;

  const TokenFormInfo({
    required this.formFieldState,
    required this.tokenDenominationModelNotifier,
    required this.totalBalanceModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 7),
        if (formFieldState.hasError) ...<Widget>[
          Text(
            formFieldState.errorText!,
            style: textTheme.caption!.copyWith(
              color: DesignColors.red_100,
            ),
          ),
        ],
        ValueListenableBuilder<TokenDenominationModel?>(
          valueListenable: tokenDenominationModelNotifier,
          builder: (_, TokenDenominationModel? tokenDenominationModel, __) {
            if (tokenDenominationModel == null || totalBalanceModel == null) {
              return const SizedBox();
            }
            TokenAmountModel availableTokenAmountModel = totalBalanceModel!.availableTokenAmountModel;
            String availableAmountText = availableTokenAmountModel.getAmountInDenomination(tokenDenominationModel).toString();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 7),
                Text(
                  'Available: ${availableAmountText} ${tokenDenominationModel.name}',
                  style: textTheme.caption!.copyWith(
                    color: formFieldState.hasError ? DesignColors.red_100 : DesignColors.gray2_100,
                  ),
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        ),
      ],
    );
  }
}
