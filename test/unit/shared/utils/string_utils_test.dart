import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/string_utils.dart';

void main() {
  group('Tests of splitBigNumber() method', () {
    test('Should return parsed "10000000000000000000000000000000000000" to "10 000 000 000 000 000 000 000 000 000 000 000 000"', () {
      // Actual
      String actualNumberString = StringUtils.splitBigNumber('10000000000000000000000000000000000000');

      // Assert
      String expectedNumberString = '10 000 000 000 000 000 000 000 000 000 000 000 000';
      expect(actualNumberString, expectedNumberString);
    });

    test('Should return parsed "100000000" to "100 000 000"', () {
      // Actual
      String actualNumberString = StringUtils.splitBigNumber('100000000');

      // Assert
      String expectedNumberString = '100 000 000';
      expect(actualNumberString, expectedNumberString);
    });

    test('Should return parsed "1000" to "1 000"', () {
      // Actual
      String actualNumberString = StringUtils.splitBigNumber('1000');

      // Assert
      String expectedNumberString = '1 000';
      expect(actualNumberString, expectedNumberString);
    });

    test('Should return an unparsed number if the number is less than 1000 (100)', () {
      // Actual
      String actualNumberString = StringUtils.splitBigNumber('100');

      // Assert
      String expectedNumberString = '100';
      expect(actualNumberString, expectedNumberString);
    });

    test('Should return an unparsed number if the number is less than 1000 (10)', () {
      // Actual
      String actualNumberString = StringUtils.splitBigNumber('10');

      // Assert
      String expectedNumberString = '10';
      expect(actualNumberString, expectedNumberString);
    });

    test('Should return an unparsed number if the number is less than 1000 (1)', () {
      // Actual
      String actualNumberString = StringUtils.splitBigNumber('1');

      // Assert
      String expectedNumberString = '1';
      expect(actualNumberString, expectedNumberString);
    });

    test('Should throw AssertionError for floating point number', () {
      expect(
        () => StringUtils.splitBigNumber('1.5'),
        throwsAssertionError,
      );
    });

    test('Should throw AssertionError for invalid number string', () {
      expect(
        () => StringUtils.splitBigNumber('100000 0000000000000 000'),
        throwsAssertionError,
      );
    });

    test('Should throw AssertionError for invalid number string', () {
      expect(
        () => StringUtils.splitBigNumber('abcdefg'),
        throwsAssertionError,
      );
    });
  });

  group('Tests of compareStrings() method', () {
    test('Should return true if text contains formatted pattern', () {
      // Act
      bool actualContainsPattern = StringUtils.compareStrings('Zażółć gęślą jaźń', 'ges');

      // Assert
      expect(actualContainsPattern, true);
    });
    test('Should remove blank spaces and return true', () {
      // Act
      bool actualContainsPattern = StringUtils.compareStrings('Genesis of Decentralized Finance', 'sisof');

      // Assert
      expect(actualContainsPattern, true);
    });
    test('Should return true if text contains formatted pattern', () {
      // Act
      bool actualContainsPattern = StringUtils.compareStrings('Zażółć gęślą jaźń', 'GęŚląJAzŃ');

      // Assert
      expect(actualContainsPattern, true);
    });
  });
}
