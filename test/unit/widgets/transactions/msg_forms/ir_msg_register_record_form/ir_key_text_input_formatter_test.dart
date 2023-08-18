import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/views/pages/transactions/msg_forms/ir_msg_register_record_form/ir_key_text_input_formatter.dart';

void main() {
  group('Tests of IRKeyTextInputFormatter.formatEditUpdate()', () {
    // Arrange
    IRKeyTextInputFormatter actualIrKeyTextInputFormatter = IRKeyTextInputFormatter();

    test('Should return [new value] if text starts with [letter]', () {
      TextEditingValue actualOldTextEditingValue = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      TextEditingValue actualNewTextEditingValue = const TextEditingValue(
        text: 'valid_ir_key',
        selection: TextSelection.collapsed(offset: 14),
      );

      // Act
      TextEditingValue actualTextEditingValue = actualIrKeyTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

      // Assert
      TextEditingValue expectedTextEditingValue = const TextEditingValue(
        text: 'valid_ir_key',
        selection: TextSelection.collapsed(offset: 14),
      );

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return [old value] if text starts with [number]', () {
      TextEditingValue actualOldTextEditingValue = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      TextEditingValue actualNewTextEditingValue = const TextEditingValue(
        text: '123_invalid_ir_key',
        selection: TextSelection.collapsed(offset: 20),
      );

      // Act
      TextEditingValue actualTextEditingValue = actualIrKeyTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

      // Assert
      TextEditingValue expectedTextEditingValue = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return [old value] if text starts with [underscore]', () {
      TextEditingValue actualOldTextEditingValue = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      TextEditingValue actualNewTextEditingValue = const TextEditingValue(
        text: '_invalid_ir_key',
        selection: TextSelection.collapsed(offset: 17),
      );

      // Act
      TextEditingValue actualTextEditingValue = actualIrKeyTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

      // Assert
      TextEditingValue expectedTextEditingValue = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );

      expect(actualTextEditingValue, expectedTextEditingValue);
    });
  });
}
