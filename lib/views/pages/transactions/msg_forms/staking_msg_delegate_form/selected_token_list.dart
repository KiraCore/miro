import 'package:flutter/material.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/views/widgets/generic/token_avatar.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';

class SelectedTokenList extends StatelessWidget {
  final ValueChanged<int> delete;
  final List<TokenAmountModel> tokenAmountModels;

  const SelectedTokenList({
    required this.delete,
    required this.tokenAmountModels,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        for (int i = 0; i < tokenAmountModels.length; i++)
          Column(
            children: <Widget>[
              TxInputWrapper(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TokenAvatar(
                      iconUrl: tokenAmountModels[i].tokenAliasModel.icon,
                      size: 45,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            '${tokenAmountModels[i].getAmountInDefaultDenomination()} ${tokenAmountModels[i].tokenAliasModel.defaultTokenDenominationModel.name}',
                            style: Theme.of(context).textTheme.bodyText1),
                      ),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => delete(i),
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
            ],
          )
      ],
    );
  }
}
