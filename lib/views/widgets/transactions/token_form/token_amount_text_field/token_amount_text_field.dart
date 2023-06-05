import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_cubit.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_field_actions.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_input_formatter.dart';
import 'package:miro/views/widgets/transactions/tx_input_static_label.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';
import 'package:miro/views/widgets/transactions/tx_text_field.dart';

class TokenAmountTextField extends StatefulWidget {
  final bool disabledBool;
  final bool errorExistsBool;
  final TextEditingController textEditingController;
  final TokenDenominationModel? tokenDenominationModel;

  const TokenAmountTextField({
    required this.disabledBool,
    required this.textEditingController,
    required this.tokenDenominationModel,
    this.errorExistsBool = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TokenAmountTextField();
}

class _TokenAmountTextField extends State<TokenAmountTextField> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(_handleTextFieldChanged);
    focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_handleTextFieldChanged);
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool disabledBool = widget.disabledBool || widget.tokenDenominationModel == null;

    return Column(
      children: <Widget>[
        TxInputWrapper(
          disabled: disabledBool,
          height: 80,
          hasErrors: widget.errorExistsBool,
          child: SizedBox(
            height: double.infinity,
            child: Center(
              child: TxInputStaticLabel(
                label: S.of(context).balancesAmount,
                contentPadding: const EdgeInsets.only(top: 9, bottom: 5),
                child: TxTextField(
                  maxLines: 1,
                  focusNode: focusNode,
                  hasErrors: widget.errorExistsBool,
                  disabled: disabledBool,
                  textEditingController: widget.textEditingController,
                  inputFormatters: <TextInputFormatter>[
                    TokenAmountTextInputFormatter(tokenDenominationModel: widget.tokenDenominationModel),
                  ],
                  onChanged: (_) => _handleTextFieldChanged(),
                ),
              ),
            ),
          ),
        ),
        TokenAmountTextFieldActions(disabled: disabledBool),
      ],
    );
  }

  void _handleTextFieldChanged() {
    String text = widget.textEditingController.text;
    BlocProvider.of<TokenFormCubit>(context).notifyTokenAmountTextChanged(text);
  }

  void _handleFocusChanged() {
    bool focusedBool = focusNode.hasFocus;
    String text = widget.textEditingController.text;
    if (focusedBool == false && text.isEmpty) {
      widget.textEditingController.text = '0';
    } else if (focusedBool && text == '0') {
      widget.textEditingController.text = '';
    }
  }
}
