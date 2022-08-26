import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/transactions/token_form/token_form_cubit.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_field_actions.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_input_formatter.dart';
import 'package:miro/views/widgets/transactions/tx_input_static_label.dart';
import 'package:miro/views/widgets/transactions/tx_input_wrapper.dart';
import 'package:miro/views/widgets/transactions/tx_text_field.dart';

class TokenAmountTextField extends StatefulWidget {
  final bool disabled;
  final TextEditingController textEditingController;
  final bool hasErrors;
  final ValueNotifier<TokenDenominationModel?> tokenDenominationModelNotifier;

  const TokenAmountTextField({
    required this.disabled,
    required this.textEditingController,
    required this.tokenDenominationModelNotifier,
    this.hasErrors = false,
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
    return ValueListenableBuilder<TokenDenominationModel?>(
      valueListenable: widget.tokenDenominationModelNotifier,
      builder: (_, TokenDenominationModel? tokenDenominationModel, __) {
        bool disabled = widget.disabled || tokenDenominationModel == null;

        return Column(
          children: <Widget>[
            TxInputWrapper(
              disabled: disabled,
              height: 80,
              hasErrors: widget.hasErrors,
              child: SizedBox(
                height: double.infinity,
                child: Center(
                  child: TxInputStaticLabel(
                    label: 'Amount',
                    contentPadding: const EdgeInsets.only(top: 9, bottom: 5),
                    child: TxTextField(
                      focusNode: focusNode,
                      hasErrors: widget.hasErrors,
                      disabled: disabled,
                      textEditingController: widget.textEditingController,
                      inputFormatters: <TextInputFormatter>[
                        TokenAmountTextInputFormatter(
                          tokenDenominationModel: tokenDenominationModel,
                        ),
                      ],
                      onChanged: (_) => _handleTextFieldChanged(),
                    ),
                  ),
                ),
              ),
            ),
            TokenAmountTextFieldActions(
              disabled: disabled,
            ),
          ],
        );
      },
    );
  }

  void _handleTextFieldChanged() {
    String text = widget.textEditingController.text;
    BlocProvider.of<TokenFormCubit>(context).setTokenAmountValue(text);
  }

  void _handleFocusChanged() {
    bool hasFocus = focusNode.hasFocus;
    bool focusCanceled = !hasFocus;
    String text = widget.textEditingController.text;
    if (focusCanceled && text.isEmpty) {
      widget.textEditingController.text = '0';
    } else if (hasFocus && text == '0') {
      widget.textEditingController.text = '';
    }
  }
}
