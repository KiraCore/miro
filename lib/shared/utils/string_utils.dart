import 'package:decimal/decimal.dart';
import 'package:uuid/uuid.dart';

class StringUtils {
  static RegExp basicCharactersRegExp = RegExp('[a-zA-Z0-9 !"#\$%\'()*+,-./:;=?@\\[\\\\\\]^_`{|}~]');
  static RegExp whitespacesRegExp = RegExp(r'\s');

  static String generateUuid() {
    return const Uuid().v4();
  }

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

  static bool compareStrings(String text, String pattern) {
    String formattedText = _unifyString(text);
    String formattedPattern = _unifyString(pattern);

    return _containsPattern(formattedText, formattedPattern);
  }

  static String _unifyString(String text) {
    return _removeDiacritics(text.toLowerCase()).replaceAll(' ', '');
  }

  static bool _containsPattern(String text, String pattern) {
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
