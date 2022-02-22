class StringUtils {
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
    String withDia =
        'ĀĄÀÁÂÃÄÅàáâãäåāąÇĆČçćčĎĐÐđďÈÉÊËĚĒĘèéêëěēęðÌÍÎÏĪìíîïīŁłŇŃÑñňńÒÓÔÕÕÖØŌòóôõöøōŘřŠŚšśŤťŮŪÙÚÛÜùúûüůūŸÝÿýŽŻŹžżź';
    String withoutDia =
        'AAAAAAAAaaaaaaaaCCCcccDDDddEEEEEEEeeeeeeeeIIIIIiiiiiLlNNNnnnOOOOOOOOoooooooRrSSssTtUUUUUUuuuuuuYYyyZZZzzz';

    for (int i = 0; i < withDia.length; i++) {
      actualText = actualText.replaceAll(withDia[i], withoutDia[i]);
    }

    return actualText;
  }
}
