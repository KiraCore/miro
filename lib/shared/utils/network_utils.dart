class NetworkUtils {
  static RegExp ipAddressRegExp =
      RegExp(r'^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$', caseSensitive: false, multiLine: false);

  static Uri parseUrl(String urlToParse) {
    try {
      Uri uriFromUrl = _parseStringToUriWithSchema(urlToParse);
      String finalUrl = '${uriFromUrl.scheme.isNotEmpty ? uriFromUrl.scheme : 'http'}://${uriFromUrl.host}';
      if (_isIpAddress(uriFromUrl.host)) {
        if (!<int>[0, 80, 443].contains(uriFromUrl.port)) {
          finalUrl += ':${uriFromUrl.port}';
        } else {
          finalUrl += ':11000';
        }
      }
      Uri resultUri = Uri.parse(finalUrl);
      return resultUri.replace(
          queryParameters: uriFromUrl.queryParameters.isNotEmpty ? uriFromUrl.queryParameters : null);
    } on FormatException {
      rethrow;
    }
  }

  static bool _isIpAddress(String text) {
    try {
      Uri uri = _parseStringToUriWithSchema(text);
      bool isValid = ipAddressRegExp.hasMatch(uri.host);
      return isValid;
    } on FormatException {
      return false;
    }
  }

  static Uri _parseStringToUriWithSchema(String text) {
    try {
      Uri uri = Uri.parse(text);
      if (uri.host.isEmpty) {
        throw const FormatException();
      }
      return uri;
    } on FormatException {
      if (text.contains('http')) {
        rethrow;
      }
      return _parseStringToUriWithSchema('http://$text');
    }
  }
}
