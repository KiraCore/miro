import 'package:flutter/services.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TokenAmountTextInputFormatter extends TextInputFormatter {
  static RegExp amountRegex = RegExp(r'^((0?\.((0[1-9])|\d*))|([1-9]\d*(\.\d*)?)|(\d))$');
  final TokenDenominationModel? tokenDenominationModel;

  TokenAmountTextInputFormatter({
    required this.tokenDenominationModel,
  });

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    List<String> letterArray = newValue.text.split('');
    String lastLetter = letterArray.isNotEmpty ? letterArray.last : '';
    bool isLastLetterNumber = RegExp('[0-9]').hasMatch(lastLetter);
    bool secondLetter = newValue.text.length == 2;
    bool startsWithZero = newValue.text.startsWith('0');
    bool shouldReplace = secondLetter && startsWithZero && isLastLetterNumber;

    int availableDecimals = tokenDenominationModel?.decimals ?? 0;
    List<String> valueSplit = newValue.text.split('.');

    // limit number of decimal places
    if (availableDecimals == 0 && newValue.text.contains('.')) {
      return oldValue;
    } else if (valueSplit.length > 1 && valueSplit[1].length > availableDecimals) {
      return oldValue;
    }

    if (newValue.text.isEmpty) {
      return newValue;
    } else if (shouldReplace) {
      return oldValue.copyWith(text: lastLetter);
    } else if (amountRegex.hasMatch(newValue.text)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
