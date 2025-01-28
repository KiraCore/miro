import 'package:flutter/material.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_field_actions.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_field_content.dart';
import 'package:miro/views/widgets/transactions/tx_input_static_label.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';

class TokenAmountTextField extends StatelessWidget {
  final bool disabledBool;
  final bool errorExistsBool;
  final String label;
  final TextEditingController textEditingController;
  final TokenDenominationModel? tokenDenominationModel;

  const TokenAmountTextField({
    required this.disabledBool,
    required this.label,
    required this.textEditingController,
    required this.tokenDenominationModel,
    this.errorExistsBool = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool correctDisabledBool = disabledBool || tokenDenominationModel == null;

    return Column(
      children: <Widget>[
        TxInputWrapper(
          disabled: correctDisabledBool,
          height: 80,
          hasErrors: errorExistsBool,
          builderWithFocus: (FocusNode focusNode) => SizedBox(
            height: double.infinity,
            child: Center(
              child: TxInputStaticLabel(
                label: label,
                contentPadding: const EdgeInsets.only(top: 9, bottom: 5),
                child: TokenAmountTextFieldContent(
                  disabledBool: correctDisabledBool,
                  label: label,
                  textEditingController: textEditingController,
                  tokenDenominationModel: tokenDenominationModel,
                  focusNode: focusNode,
                  errorExistsBool: errorExistsBool,
                ),
              ),
            ),
          ),
        ),
        TokenAmountTextFieldActions(disabled: correctDisabledBool),
      ],
    );
  }
}
