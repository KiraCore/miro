import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/transactions/token_form/token_form_cubit.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/utils/transactions/tx_utils.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_input_formatter.dart';
import 'package:miro/views/widgets/transactions/tx_text_field.dart';

class TokenAmountTextFieldContent extends StatefulWidget {
  final bool disabledBool;
  final String label;
  final TextEditingController textEditingController;
  final TokenDenominationModel? tokenDenominationModel;
  final FocusNode focusNode;
  final bool errorExistsBool;

  const TokenAmountTextFieldContent({
    required this.disabledBool,
    required this.label,
    required this.textEditingController,
    required this.tokenDenominationModel,
    required this.focusNode,
    this.errorExistsBool = false,
    super.key,
  });

  @override
  State<TokenAmountTextFieldContent> createState() => _TokenAmountTextFieldContentState();
}

class _TokenAmountTextFieldContentState extends State<TokenAmountTextFieldContent> {
  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(_handleTextFieldChanged);
    widget.focusNode.addListener(_handleFocusChanged);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_handleTextFieldChanged);
    widget.focusNode.removeListener(_handleFocusChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxTextField(
      maxLines: 1,
      focusNode: widget.focusNode,
      hasErrors: widget.errorExistsBool,
      disabled: widget.disabledBool,
      textEditingController: widget.textEditingController,
      inputFormatters: <TextInputFormatter>[
        TokenAmountTextInputFormatter(tokenDenominationModel: widget.tokenDenominationModel),
      ],
      onChanged: (_) => _handleTextFieldChanged(),
    );
  }

  void _handleTextFieldChanged() {
    String text = widget.textEditingController.text;
    BlocProvider.of<TokenFormCubit>(context).notifyTokenAmountTextChanged(text);
  }

  void _handleFocusChanged() {
    bool focusedBool = widget.focusNode.hasFocus;
    String text = widget.textEditingController.text;
    String displayedAmount = TxUtils.buildAmountString(text, widget.tokenDenominationModel);
    if (focusedBool == false && text.isEmpty) {
      widget.textEditingController.text = '0';
    } else if (focusedBool == false) {
      widget.textEditingController.text = displayedAmount;
    } else if (focusedBool && text == '0') {
      widget.textEditingController.text = '';
    }
  }
}
