import 'package:flutter/services.dart';

class IRKeyTextInputFormatter extends TextInputFormatter {
  IRKeyTextInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    } else if (RegExp('[A-Za-z]').hasMatch(newValue.text.substring(0, 1))) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
