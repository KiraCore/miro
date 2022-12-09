class NetworkUtils {
  static RegExp ipAddressRegExp = RegExp(r'^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$', caseSensitive: false, multiLine: false);

  static Uri parseUrlToInterxUri(String urlToParse) {
    Uri uri = parseNoSchemeToHTTPS(urlToParse);
    uri = _assignDefaultPort(uri);
    return uri;
  }

  static Uri parseNoSchemeToHTTPS(String urlToParse) {
    String parsedUrl = urlToParse;
    if (parsedUrl.endsWith('/')) {
      parsedUrl = parsedUrl.substring(0, parsedUrl.length - 1);
    }

    late Uri uri;
    if (parsedUrl.startsWith('http://') || parsedUrl.startsWith('https://')) {
      uri = Uri.parse(parsedUrl);
    } else {
      uri = Uri.parse('https://$parsedUrl');
    }

    if (_isLocalhost(uri)) {
      uri = uri.replace(scheme: 'http');
    }
    return uri;
  }

  static Uri _assignDefaultPort(Uri uri) {
    List<int> ignoredPorts = <int>[0, 80, 443];

    // If uri is domain name, then return uri without changes, because domains don't have ports
    // If uri is localhost address, then return uri without changes, because user specifies port
    if (!_isIpAddress(uri) || _isLocalhost(uri)) {
      return uri;
    }

    if (ignoredPorts.contains(uri.port)) {
      // If uri is IP address without port specified, then assign default port
      return uri.replace(port: 11000);
    }

    // If uri is IP address with port specified then return uri with custom port
    return uri;
  }

  static bool _isIpAddress(Uri uri) {
    try {
      return ipAddressRegExp.hasMatch(uri.host);
    } on FormatException {
      return false;
    }
  }

  static bool _isLocalhost(Uri uri) {
    List<String> localhostAddress = <String>['localhost', '127.0.0.1', '0.0.0.0'];

    if (localhostAddress.contains(uri.host)) {
      return true;
    }
    return false;
  }
}
