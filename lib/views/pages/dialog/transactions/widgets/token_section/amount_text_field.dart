import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/decorated_input.dart';

class AmountTextField extends StatelessWidget {
  final void Function(Decimal) onChanged;
  final void Function(String) onError;
  final TextEditingController textEditingController;
  final bool disabled;

  const AmountTextField({
    required this.onChanged,
    required this.onError,
    required this.textEditingController,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.4 : 1,
      child: DecoratedInput(
        childHeight: 45,
        child: TextFormField(
          controller: textEditingController,
          onChanged: _handleAmountTextChanged,
          enabled: !disabled,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))],
          decoration: InputDecoration(
            isDense: false,
            hintText: disabled ? '---' : '0',
            hintStyle: const TextStyle(color: DesignColors.white_100),
            labelStyle: const TextStyle(fontSize: 14),
            floatingLabelStyle: const TextStyle(fontSize: 14),
            contentPadding: const EdgeInsets.only(bottom: 8),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: const Text(
              'Amount',
              style: TextStyle(color: DesignColors.gray2_100),
            ),
          ),
        ),
      ),
    );
  }

  void _handleAmountTextChanged(String value) {
    Decimal? amount = _tryParseAmountText(value);
    if (amount != null) {
      onChanged(amount);
    } else {
      onError('Invalid value');
    }
  }

  Decimal? _tryParseAmountText(String value) {
    return Decimal.tryParse(value);
  }
}
