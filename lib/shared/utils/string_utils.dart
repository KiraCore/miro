import 'package:decimal/decimal.dart';
import 'package:uuid/uuid.dart';

class StringUtils {
  static RegExp basicCharactersRegExp = RegExp('[a-zA-Z0-9 !"#\$%\'()*+,-./<>:;=?@\\[\\\\\\]^_`{|}~]');
  static RegExp nonAlphabeticalCharactersRegexp = RegExp('[^a-zA-Z]+');
  static RegExp irKeyRegExp = RegExp('[a-zA-Z0-9_]');
  static RegExp irValueRegExp = RegExp(r'(\p{Alpha})|([0-9 \n\t\s!"#$%()*+,\-./<>:;=?@[\]^_{|\}~`])', unicode: true);
  static RegExp irUsernameRegExp = RegExp('[a-zA-Z0-9_ ]');
  static RegExp whitespacesRegExp = RegExp(r'\s');

  static String? findFirstDelimiter(String text) {
    RegExpMatch? regExpMatch = nonAlphabeticalCharactersRegexp.firstMatch(text);
    return regExpMatch?.group(0);
  }

  static String generateUuid() {
    return const Uuid().v4();
  }

  static String parseUnicodeToString(String text) {
    String parsedText = text.replaceAllMapped(RegExp(r'\\u[0-9a-fA-F]{4}'), (Match match) {
      final String hex = match.group(0)!.replaceAll(r'\u', '');
      final int code = int.parse(hex, radix: 16);
      return String.fromCharCode(code);
    });
    return parsedText;
  }

  /// Checks if given input is an integer.
  /// Adds whitespaces to a big [number] given as a String, to make it easier to read.
  /// Example: 25000000 -> 25 000 000.
  static String splitBigNumber(String number) {
    bool isInteger = Decimal.tryParse(number)?.isInteger == true;
    if (isInteger == false) {
      throw AssertionError('The number must be an integer.');
    }

    List<String> newNumberList = List<String>.empty(growable: true);
    for (int i = number.length; i > 0; i -= 3) {
      if (i < 3) {
        newNumberList.add(number.substring(0, i));
      } else {
        newNumberList.add(number.substring(i - 3, i));
      }
    }
    return newNumberList.reversed.join(' ');
  }

  static bool hasPatternsAfterUnified(String text, String pattern) {
    String formattedText = _unifyString(text);
    String formattedPattern = _unifyString(pattern);

    return _hasPattern(formattedText, formattedPattern);
  }

  static String _unifyString(String text) {
    return _removeDiacritics(text.toLowerCase()).replaceAll(' ', '');
  }

  static bool _hasPattern(String text, String pattern) {
    return text.contains(RegExp(pattern, caseSensitive: false));
  }

  static String _removeDiacritics(String text) {
    String actualText = text;
    String withDia = 'ĀĄÀÁÂÃÄÅàáâãäåāąÇĆČçćčĎĐÐđďÈÉÊËĚĒĘèéêëěēęðÌÍÎÏĪìíîïīŁłŇŃÑñňńÒÓÔÕÕÖØŌòóôõöøōŘřŠŚšśŤťŮŪÙÚÛÜùúûüůūŸÝÿýŽŻŹžżź';
    String withoutDia = 'AAAAAAAAaaaaaaaaCCCcccDDDddEEEEEEEeeeeeeeeIIIIIiiiiiLlNNNnnnOOOOOOOOoooooooRrSSssTtUUUUUUuuuuuuYYyyZZZzzz';

    for (int i = 0; i < withDia.length; i++) {
      actualText = actualText.replaceAll(withDia[i], withoutDia[i]);
    }

    return actualText;
  }
}
