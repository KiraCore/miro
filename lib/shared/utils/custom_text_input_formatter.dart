import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CustomTextInputFormatter {
  static List<TextInputFormatter> getIntFormatter({required double maxValue}) => <TextInputFormatter>[
        _IntTextInputFormatter(maxValue: maxValue),
        FilteringTextInputFormatter.allow(RegExp('[1234567890]'))
      ];
}

abstract class _BaseTextInputFormatter extends TextInputFormatter {
  double? maxValue;

  _BaseTextInputFormatter({this.maxValue});

  String getDisplayNumber(num? number) {
    if (number == null) return '0';
    String pattern = '###';

    List<String> arr = number.toString().split('.');

    if (arr.length > 1) {
      if (arr[1].length >= 2) {
        if (arr[1] == '00') {
          pattern = '${pattern}0';
        } else {
          pattern = '${pattern}0.00';
        }
      } else {
        if (arr[1] == '0') {
          pattern = '${pattern}0';
        } else {
          pattern = '${pattern}0.0';
        }
      }
    } else {
      pattern = '${pattern}0';
    }

    return NumberFormat(pattern, 'en_US').format(number);
  }

  String checkMaxValue(String value) {
    if (maxValue == null) {
      return value;
    }

    try {
      if (double.parse(value) > maxValue!) {
        return getDisplayNumber(maxValue);
      }
    } catch (e) {
      // return value;
    }

    return value;
  }
}

class _IntTextInputFormatter extends _BaseTextInputFormatter {
  _IntTextInputFormatter({
    required double maxValue,
  }) : super(maxValue: maxValue);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String oldText = oldValue.text;
    String newText = newValue.text;

    int selectionIndex = newValue.selection.end;

    if (oldText == '0') {
      newText = newText.substring(1, newText.length);
    }

    newText = checkMaxValue(newText);
    selectionIndex = newText.length;

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
