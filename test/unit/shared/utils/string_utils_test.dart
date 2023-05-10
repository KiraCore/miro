import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/utils/string_utils.dart';

void main() {
  group('Tests of [StringUtils.basicCharactersRegExp]', () {
    test(
        'Should return amount of characters (90) matching "basicCharactersRegExp" ["abcdefghijklmnoprstuwyzxABCDEFGHIJKLMNOPRSTUWYZX0123456789 !"#\$%\'()*+,-./<>:;=?@[\\]^_`{|}~"]',
        () {
      // Arrange
      String testString = 'abcdefghijklmnoprstuwyzxABCDEFGHIJKLMNOPRSTUWYZX0123456789 !"#\$%\'()*+,-./<>:;=?@[\\]^_`{|}~';

      // Act
      int actualMatchLength = StringUtils.basicCharactersRegExp.allMatches(testString).length;

      // Assert
      expect(actualMatchLength, 90);
    });

    test('Should return amount of characters (0) matching "basicCharactersRegExp" ["©Ω௵⇊⇊"]', () {
      // Arrange
      String testString = '©Ω௵⇊⇊';

      // Act
      int actualMatchLength = StringUtils.basicCharactersRegExp.allMatches(testString).length;

      // Assert
      expect(actualMatchLength, 0);
    });
  });

  group('Tests of [StringUtils.whitespacesRegExp]', () {
    test('Should return "true" if text contains whitespaces [" "]', () {
      // Act
      bool actualMatchExistsBool = StringUtils.whitespacesRegExp.hasMatch(' ');

      // Assert
      expect(actualMatchExistsBool, true);
    });

    test('Should return "true" if text contains whitespaces [" t e st "]', () {
      // Act
      bool actualMatchExistsBool = StringUtils.whitespacesRegExp.hasMatch(' t e st ');

      // Assert
      expect(actualMatchExistsBool, true);
    });

    test('Should return "false" if text does not contain whitespaces ["test"]', () {
      // Act
      bool actualMatchExistsBool = StringUtils.whitespacesRegExp.hasMatch('test');

      // Assert
      expect(actualMatchExistsBool, false);
    });
  });

  group('Tests of StringUtils.splitBigNumber() method', () {
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

  group('Tests of StringUtils.compareStrings() method', () {
    test('Should ignore diacritics and return "true" if text contains pattern', () {
      // Act
      bool actualContainsPatternBool = StringUtils.compareStrings('Zażółć gęślą jaźń', 'ges');

      // Assert
      expect(actualContainsPatternBool, true);
    });

    test('Should ignore whitespaces and return "true" if text contains pattern', () {
      // Act
      bool actualContainsPatternBool = StringUtils.compareStrings('Genesis of Decentralized Finance', 'sisof');

      // Assert
      expect(actualContainsPatternBool, true);
    });

    test('Should ignore whitespaces and return "true" if text contains pattern', () {
      // Act
      bool actualContainsPatternBool = StringUtils.compareStrings('Zażółć gęślą jaźń', 'GęŚląJAzŃ');

      // Assert
      expect(actualContainsPatternBool, true);
    });

    test('Should ignore whitespaces and return "false" if text does not contain pattern', () {
      // Act
      bool actualContainsPatternBool = StringUtils.compareStrings('Zażółć gęślą jaźń', 'Hello world!');

      // Assert
      expect(actualContainsPatternBool, false);
    });
  });
}
