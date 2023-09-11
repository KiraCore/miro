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

  group('Tests of [StringUtils.nonAlphabeticalCharactersRegexp]', () {
    test('Should return null for string containing only alphabetical characters ["abcdefghijklmnoprstuwyzxABCDEFGHIJKLMNOPRSTUWYZX"]', () {
      // Arrange
      String testString = 'abcdefghijklmnoprstuwyzxABCDEFGHIJKLMNOPRSTUWYZX';

      // Act
      String? actualStringMatch = StringUtils.nonAlphabeticalCharactersRegexp.stringMatch(testString);

      // Assert
      expect(actualStringMatch, null);
    });

    test('Should match all characters for string containing only non-alphabetical characters [1234567890~ \n\t`~!@#\$%^&*()[]{};\':"]', () {
      // Arrange
      String testString = '1234567890~ \n\t`~!@#\$%^&*()[]{};\':"';

      // Act
      String? actualStringMatch = StringUtils.nonAlphabeticalCharactersRegexp.stringMatch(testString);

      // Assert
      String expectedStringMatch = testString;
      expect(actualStringMatch, expectedStringMatch);
    });

    test('Should match first group of non-alphabetical characters for string with alphabetical and not-alphabetical characters [abc123cba321]', () {
      // Arrange
      String testString = 'abc123cba321';

      // Act
      String? actualStringMatch = StringUtils.nonAlphabeticalCharactersRegexp.stringMatch(testString);

      // Assert
      String expectedStringMatch = '123';
      expect(actualStringMatch, expectedStringMatch);
    });
  });

  group('Tests of [StringUtils.irKeyRegExp]', () {
    test('Should return amount of characters (59) matching "jsonKeyRegExp" ["abcdefghijklmnoprstuwyzxABCDEFGHIJKLMNOPRSTUWYZX0123456789_"]', () {
      // Arrange
      String testString = 'abcdefghijklmnoprstuwyzxABCDEFGHIJKLMNOPRSTUWYZX0123456789_';

      // Act
      int actualMatchLength = StringUtils.irKeyRegExp.allMatches(testString).length;

      // Assert
      expect(actualMatchLength, 59);
    });

    test('Should return amount of characters (0) matching "jsonKeyRegExp" ["!"#\$%\'()*+,-./<>:;=?@[\\]^`{|}~©Ω௵⇊⇊"]', () {
      // Arrange
      String testString = '!"#\$%\'()*+,-./<>:;=?@[\\]^`{|}~©Ω௵⇊⇊';

      // Act
      int actualMatchLength = StringUtils.irKeyRegExp.allMatches(testString).length;

      // Assert
      expect(actualMatchLength, 0);
    });
  });

  group('Tests of [StringUtils.irValueRegExp]', () {
    test('Should return amount of characters (368) matching "alphanumericRegExp"', () {
      // Arrange
      String testString =
          r'áăắặằẳẵǎâấậầẩẫäǟȧǡạȁàảȃāąᶏẚåǻḁⱥãćčçḉĉɕċƈȼéĕěȩḝêếệềểễḙëėẹȅèẻȇēḗḕⱸęᶒɇẽḛíĭǐîïḯịȉìỉȋīįᶖɨĩḭńňņṋȵṅṇǹɲṉƞᵰᶇɳñóŏǒôốộồổỗöȫȯȱọőȍòỏơớợờởỡȏōṓṑǫǭøǿõṍṏȭúŭǔûṷüǘǚǜǖṳụűȕùủưứựừửữȗūṻųᶙůũṹṵÁĂẮẶẰẲẴǍÂẤẬẦẨẪÄǞȦǠẠȀÀẢȂĀĄᶏAʾÅǺḀȺÃĆČÇḈĈɕĊƇȻÉĔĚȨḜÊẾỆỀỂỄḘËĖẸȄÈẺȆĒḖḔⱸĘᶒɆẼḚÍĬǏÎÏḮỊȈÌỈȊĪĮᶖƗĨḬŃŇŅṊȵṄṆǸƝṈȠᵰᶇɳÑÓŎǑÔỐỘỒỔỖÖȪȮȰỌŐȌÒỎƠỚỢỜỞỠȎŌṒṐǪǬØǾÕṌṎȬÚŬǓÛṶÜǗǙǛǕṲỤŰȔÙỦƯỨỰỪỬỮȖŪṺŲᶙŮŨṸṴ !"#$%()*+,-./<>:;=?@[]^_`{|}~]';

      // Act
      int actualMatchLength = StringUtils.irValueRegExp.allMatches(testString).length;

      // Assert
      expect(actualMatchLength, 368);
    });

    test('Should return amount of characters (0) matching "alphanumericRegExp"', () {
      // Arrange
      String testString = '©௵⇊⇊';

      // Act
      int actualMatchLength = StringUtils.irValueRegExp.allMatches(testString).length;

      // Assert
      expect(actualMatchLength, 0);
    });
  });

  group('Tests of [StringUtils.irUsernameRegExp]', () {
    test('Should return amount of characters (0) matching "irUsernameRegExp"', () {
      // Arrange
      String testString =
          r'áăắặằẳẵǎâấậầẩẫäǟȧǡạȁàảȃāąᶏẚåǻḁⱥãćčçḉĉɕċƈȼéĕěȩḝêếệềểễḙëėẹȅèẻȇēḗḕⱸęᶒɇẽḛíĭǐîïḯịȉìỉȋīįᶖɨĩḭńňņṋȵṅṇǹɲṉƞᵰᶇɳñóŏǒôốộồổỗöȫȯȱọőȍòỏơớợờởỡȏōṓṑǫǭøǿõṍṏȭúŭǔûṷüǘǚǜǖṳụűȕùủưứựừửữȗūṻųᶙůũṹṵÁĂẮẶẰẲẴǍÂẤẬẦẨẪÄǞȦǠẠȀÀẢȂĀĄᶏÅǺḀȺÃĆČÇḈĈɕĊƇȻÉĔĚȨḜÊẾỆỀỂỄḘËĖẸȄÈẺȆĒḖḔⱸĘᶒɆẼḚÍĬǏÎÏḮỊȈÌỈȊĪĮᶖƗĨḬŃŇŅṊȵṄṆǸƝṈȠᵰᶇɳÑÓŎǑÔỐỘỒỔỖÖȪȮȰỌŐȌÒỎƠỚỢỜỞỠȎŌṒṐǪǬØǾÕṌṎȬÚŬǓÛṶÜǗǙǛǕṲỤŰȔÙỦƯỨỰỪỬỮȖŪṺŲᶙŮŨṸṴ!"#$%()*+,-./<>:;=?@[]^`{|}~]';

      // Act
      int actualMatchLength = StringUtils.irUsernameRegExp.allMatches(testString).length;

      // Assert
      expect(actualMatchLength, 0);
    });

    test('Should return amount of characters (62) matching "irUsernameRegExp"', () {
      // Arrange
      String testString = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

      // Act
      int actualMatchLength = StringUtils.irUsernameRegExp.allMatches(testString).length;

      // Assert
      expect(actualMatchLength, 62);
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

  group('Tests of StringUtils.findFirstDelimiter() method', () {
    test('Should return first non alphabetical characters string (" ")', () {
      // Arrange
      String testString = 'test test test test';

      // Act
      String? actualDelimiter = StringUtils.findFirstDelimiter(testString);

      // Assert
      String expectedDelimiter = ' ';
      expect(actualDelimiter, expectedDelimiter);
    });

    test('Should return first non alphabetical characters string ("-")', () {
      // Arrange
      String testString = 'test-test-test-test';

      // Act
      String? actualDelimiter = StringUtils.findFirstDelimiter(testString);

      // Assert
      String expectedDelimiter = '-';
      expect(actualDelimiter, expectedDelimiter);
    });

    test(r'Should return first non alphabetical characters string ("\t")', () {
      // Arrange
      String testString = 'test\ttest\ttest\ttest';

      // Act
      String? actualDelimiter = StringUtils.findFirstDelimiter(testString);

      // Assert
      String expectedDelimiter = '\t';
      expect(actualDelimiter, expectedDelimiter);
    });

    test(r'Should return first non alphabetical characters string ("\n")', () {
      // Arrange
      String testString = 'test\nest\ntest\ntest';

      // Act
      String? actualDelimiter = StringUtils.findFirstDelimiter(testString);

      // Assert
      String expectedDelimiter = '\n';
      expect(actualDelimiter, expectedDelimiter);
    });

    test('Should return first non alphabetical characters string ("123")', () {
      // Arrange
      String testString = 'test123est123test123test';

      // Act
      String? actualDelimiter = StringUtils.findFirstDelimiter(testString);

      // Assert
      String expectedDelimiter = '123';
      expect(actualDelimiter, expectedDelimiter);
    });
  });

  group('Tests of StringUtils.parseUnicodeToString() method', () {
    test('Should return String with all unicode characters parsed to appropriate symbol', () {
      // Arrange
      String actualUnicodeString =
          r'\u0020\u0021\u0022\u0023\u0024\u0025\u0026\u0027\u0028\u0029\u002A\u002B\u002C\u002D\u002E\u002F\u0030\u0031\u0032\u0033\u0034\u0035\u0036\u0037\u0038\u0039\u003A\u003B\u003C\u003D\u003E\u003F\u0040\u0041\u0042\u0043\u0044\u0045\u0046\u0047\u0048\u0049\u004A\u004B\u004C\u004D\u004E\u004F\u0050\u0051\u0052\u0053\u0054\u0055\u0056\u0057\u0058\u0059\u005A\u005B\u005C\u005D\u005E\u005F\u0060\u0061\u0062\u0063\u0064\u0065\u0066\u0067\u0068\u0069\u006A\u006B\u006C\u006D\u006E\u006F\u0070\u0071\u0072\u0073\u0074\u0075\u0076\u0077\u0078\u0079\u007A\u007B\u007C\u007D\u007E';

      // Act
      String actualString = StringUtils.parseUnicodeToString(actualUnicodeString);

      // Assert
      String expectedString = ' !"#\$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~';

      expect(actualString, expectedString);
    });

    test('Should return unchanged String if text does not contain unicode characters', () {
      // Act
      String actualString =
          StringUtils.parseUnicodeToString(' !"#\$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~');

      // Assert
      String expectedString = ' !"#\$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~';

      expect(actualString, expectedString);
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
