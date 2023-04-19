import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/views/widgets/transactions/memo_text_field/memo_length_text_input_formatter.dart';

void main() {
  group('Tests of MemoLengthTextInputFormatter.formatEditUpdate()', () {
    // Arrange
    MemoLengthTextInputFormatter actualMemoLengthTextInputFormatter = MemoLengthTextInputFormatter(32);

    group('Tests for [standard] characters', () {
      test('Should return [new value] if [text EMPTY] and [new value NOT overflowed]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: 'abcdefghij',
          selection: TextSelection.collapsed(offset: 10),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: 'abcdefghij',
          selection: TextSelection.collapsed(offset: 10),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [new value] if [text FILLED], [new value NOT overflowed] and [cursor at the END]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: 'abcdefghij',
          selection: TextSelection.collapsed(offset: 10),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: 'abcdefghijklmnoprs',
          selection: TextSelection.collapsed(offset: 18),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: 'abcdefghijklmnoprs',
          selection: TextSelection.collapsed(offset: 18),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [new value] if [text FILLED], [new value NOT overflowed] and [cursor in the MIDDLE]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: 'aaaaaaaaaa',
          selection: TextSelection.collapsed(offset: 5),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: 'aaaaaIoooIaaaaa',
          selection: TextSelection.collapsed(offset: 10),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: 'aaaaaIoooIaaaaa',
          selection: TextSelection.collapsed(offset: 10),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [TRIMMED new value] if [text EMPTY], [new value overflowed] and [cursor at the END]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: 'aaaaaaaaaabbbbbbbbbbcccccccccc123456789',
          selection: TextSelection.collapsed(offset: 39),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: 'aaaaaaaaaabbbbbbbbbbcccccccccc12',
          selection: TextSelection.collapsed(offset: 32),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [TRIMMED new value] if [text FILLED], [new value overflowed] and [cursor at the END]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: 'aaaaaaaaaa',
          selection: TextSelection.collapsed(offset: 10),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: 'aaaaaaaaaabbbbbbbbbbcccccccccc123456789',
          selection: TextSelection.collapsed(offset: 39),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: 'aaaaaaaaaabbbbbbbbbbcccccccccc12',
          selection: TextSelection.collapsed(offset: 32),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [old value] if [text FILLED], [new value overflowed] and [cursor in the MIDDLE]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: 'aaaaaaaaaa',
          selection: TextSelection.collapsed(offset: 5),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: 'aaaaaIooooIccccIoooIccccIooooIaaaaa',
          selection: TextSelection.collapsed(offset: 35),
        );

        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: 'aaaaaaaaaa',
          selection: TextSelection.collapsed(offset: 5),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });
    });

    group('Tests for [restricted] characters', () {
      test('Should return [new value] if [text EMPTY] and [new value NOT overflowed]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<><>',
          selection: TextSelection.collapsed(offset: 4),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<><>',
          selection: TextSelection.collapsed(offset: 4),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [new value] if [text FILLED], [new value NOT overflowed] and [cursor at the END]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '<>',
          selection: TextSelection.collapsed(offset: 2),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<><>',
          selection: TextSelection.collapsed(offset: 4),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<><>',
          selection: TextSelection.collapsed(offset: 4),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [new value] if [text FILLED], [new value NOT overflowed] and [cursor in the MIDDLE]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '<>',
          selection: TextSelection.collapsed(offset: 1),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<<>>',
          selection: TextSelection.collapsed(offset: 3),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<<>>',
          selection: TextSelection.collapsed(offset: 3),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [TRIMMED new value] if [text EMPTY], [new value overflowed] and [cursor at the END]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<><><><><><>',
          selection: TextSelection.collapsed(offset: 12),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<><><',
          selection: TextSelection.collapsed(offset: 5),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [TRIMMED new value] if [text FILLED], [new value overflowed] and [cursor at the END]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '<>',
          selection: TextSelection.collapsed(offset: 2),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<><><><><><>',
          selection: TextSelection.collapsed(offset: 12),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<><><',
          selection: TextSelection.collapsed(offset: 5),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [old value] if [text FILLED], [new value overflowed] and [cursor in the MIDDLE]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '<>',
          selection: TextSelection.collapsed(offset: 1),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<<<<>>>>',
          selection: TextSelection.collapsed(offset: 8),
        );

        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<>',
          selection: TextSelection.collapsed(offset: 1),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });
    });

    group('Tests for [mixed] characters', () {
      test('Should return [new value] if [text EMPTY] and [new value NOT overflowed]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<aaa>',
          selection: TextSelection.collapsed(offset: 5),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<aaa>',
          selection: TextSelection.collapsed(offset: 5),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [new value] if [text FILLED], [new value NOT overflowed] and [cursor at the END]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '<aaa>',
          selection: TextSelection.collapsed(offset: 5),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<aaa><bbb>',
          selection: TextSelection.collapsed(offset: 10),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<aaa><bbb>',
          selection: TextSelection.collapsed(offset: 10),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [new value] if [text FILLED], [new value NOT overflowed] and [cursor in the MIDDLE]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '<aa>',
          selection: TextSelection.collapsed(offset: 2),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<a<bb>a>',
          selection: TextSelection.collapsed(offset: 6),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<a<bb>a>',
          selection: TextSelection.collapsed(offset: 6),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [TRIMMED new value] if [text EMPTY], [new value overflowed] and [cursor at the END]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '',
          selection: TextSelection.collapsed(offset: 0),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<aaa><bbb><ccc><ddd><eee><fff>',
          selection: TextSelection.collapsed(offset: 30),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<aaa><bbb>',
          selection: TextSelection.collapsed(offset: 10),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [TRIMMED new value] if [text FILLED], [new value overflowed] and [cursor at the END]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '<aaa>',
          selection: TextSelection.collapsed(offset: 5),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<aaa><bbb><ccc><ddd><eee><fff>',
          selection: TextSelection.collapsed(offset: 30),
        );

        // Act
        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<aaa><bbb>',
          selection: TextSelection.collapsed(offset: 10),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });

      test('Should return [old value] if [text FILLED], [new value overflowed] and [cursor in the MIDDLE]', () {
        // Arrange
        TextEditingValue actualOldTextEditingValue = const TextEditingValue(
          text: '<aaa>',
          selection: TextSelection.collapsed(offset: 2),
        );

        TextEditingValue actualNewTextEditingValue = const TextEditingValue(
          text: '<aaa><bbb><ccc><ddd><eee><fff>',
          selection: TextSelection.collapsed(offset: 30),
        );

        TextEditingValue actualTextEditingValue = actualMemoLengthTextInputFormatter.formatEditUpdate(actualOldTextEditingValue, actualNewTextEditingValue);

        // Assert
        TextEditingValue expectedTextEditingValue = const TextEditingValue(
          text: '<aaa>',
          selection: TextSelection.collapsed(offset: 2),
        );

        expect(actualTextEditingValue, expectedTextEditingValue);
      });
    });
  });
}
