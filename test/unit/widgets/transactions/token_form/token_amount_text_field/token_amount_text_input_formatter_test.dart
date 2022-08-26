import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/views/widgets/transactions/token_form/token_amount_text_field/token_amount_text_input_formatter.dart';

// ignore_for_file: cascade_invocations
void main() {
  group('Test of TokenAmountTextInputFormatter', () {
    // Assert
    TokenAmountTextInputFormatter tokenAmountTextInputFormatter = TokenAmountTextInputFormatter(
      tokenDenominationModel: const TokenDenominationModel(decimals: 18, name: 'test'),
    );

    test('Should return newValue if valid ', () {
      TextEditingValue oldTextEditingValue = const TextEditingValue(text: '0.');
      TextEditingValue newTextEditingValue = const TextEditingValue(text: '0.10');

      // Act
      TextEditingValue actualTextEditingValue = tokenAmountTextInputFormatter.formatEditUpdate(oldTextEditingValue, newTextEditingValue);

      // Assert
      TextEditingValue expectedTextEditingValue = newTextEditingValue;

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return oldValue if newValue is invalid ', () {
      // Assert
      TextEditingValue oldTextEditingValue = const TextEditingValue(text: '0.');
      TextEditingValue newTextEditingValue = const TextEditingValue(text: '000..');

      // Act
      TextEditingValue actualTextEditingValue = tokenAmountTextInputFormatter.formatEditUpdate(oldTextEditingValue, newTextEditingValue);

      // Assert
      TextEditingValue expectedTextEditingValue = oldTextEditingValue;

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return last typed character if text begins with zero and character is other than dot ', () {
      // Assert
      TextEditingValue oldTextEditingValue = const TextEditingValue(text: '0');
      TextEditingValue newTextEditingValue = const TextEditingValue(text: '01');

      // Act
      TextEditingValue actualTextEditingValue = tokenAmountTextInputFormatter.formatEditUpdate(oldTextEditingValue, newTextEditingValue);

      // Assert
      TextEditingValue expectedTextEditingValue = const TextEditingValue(text: '1');

      expect(actualTextEditingValue, expectedTextEditingValue);
    });

    test('Should return oldValue if newValue is valid but contains dot and tokenDenominationModel has zero decimals', () {
      // Assert
      TokenAmountTextInputFormatter tokenAmountTextInputFormatter = TokenAmountTextInputFormatter(
        tokenDenominationModel: const TokenDenominationModel(decimals: 0, name: 'test'),
      );

      TextEditingValue oldTextEditingValue = const TextEditingValue(text: '0');
      TextEditingValue newTextEditingValue = const TextEditingValue(text: '0.1');

      // Act
      TextEditingValue actualTextEditingValue = tokenAmountTextInputFormatter.formatEditUpdate(oldTextEditingValue, newTextEditingValue);

      // Assert
      TextEditingValue expectedTextEditingValue = oldTextEditingValue;

      expect(actualTextEditingValue, expectedTextEditingValue);
    });
  });

  group('Tests of TokenAmountTextInputFormatter RegExp', () {
    RegExp actualRegExp = TokenAmountTextInputFormatter.amountRegex;

    test('Should return true for "0.10"', () {
      // Arrange
      String actualValue = '0.10';

      // Act
      expect(actualRegExp.hasMatch(actualValue), true);
    });

    test('Should return true for "10.10"', () {
      // Arrange
      String actualValue = '10.10';

      // Act
      expect(actualRegExp.hasMatch(actualValue), true);
    });

    test('Should return true for "10"', () {
      // Arrange
      String actualValue = '10';

      // Act
      expect(actualRegExp.hasMatch(actualValue), true);
    });

    test('Should return true for "100000000000000000000.99999999999999999999999999"', () {
      // Arrange
      String actualValue = '100000000000000000000.99999999999999999999999999';

      // Act
      expect(actualRegExp.hasMatch(actualValue), true);
    });

    test('Should return true for "1.000000000000000000000001"', () {
      // Arrange
      String actualValue = '1.000000000000000000000001';

      // Act
      expect(actualRegExp.hasMatch(actualValue), true);
    });

    test('Should return false for "00.1"', () {
      // Arrange
      String actualValue = '00.1';

      // Act
      expect(actualRegExp.hasMatch(actualValue), false);
    });

    test('Should return false for "00000000000.1"', () {
      // Arrange
      String actualValue = '00000000000.1';

      // Act
      expect(actualRegExp.hasMatch(actualValue), false);
    });

    test('Should return false for "01.0001"', () {
      // Arrange
      String actualValue = '01.0001';

      // Act
      expect(actualRegExp.hasMatch(actualValue), false);
    });

    test('Should return false for "1.1.1000"', () {
      // Arrange
      String actualValue = '1.1.1000';

      // Act
      expect(actualRegExp.hasMatch(actualValue), false);
    });

    test('Should return false for "abcd1.0"', () {
      // Arrange
      String actualValue = 'abcd1.0';

      // Act
      expect(actualRegExp.hasMatch(actualValue), false);
    });
  });
}
