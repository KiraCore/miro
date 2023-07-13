class NetworkUtils {
  static RegExp ipAddressRegExp = RegExp(r'^(?!0)(?!.*\.$)((1?\d?\d|25[0-5]|2[0-4]\d)(\.|$)){4}$', caseSensitive: false, multiLine: false);

  static Uri parseUrlToInterxUri(String urlToParse) {
    Uri uri = parseNoSchemeToHTTPS(urlToParse);
    uri = _assignDefaultPort(uri);
    return uri;
  }

  static Uri parseNoSchemeToHTTPS(String urlToParse) {
    String parsedUrl = urlToParse.trim();
    if (parsedUrl.endsWith('/')) {
      parsedUrl = parsedUrl.substring(0, parsedUrl.length - 1);
    }

    late Uri uri;

    if (parsedUrl.startsWith('http://') || parsedUrl.startsWith('https://')) {
      uri = Uri.parse(parsedUrl);
    } else {
      parsedUrl = removeScheme(parsedUrl);
      uri = Uri.parse('https://$parsedUrl');
    }

    if (isLocalhost(uri)) {
      uri = uri.replace(scheme: 'http');
    }
    return uri;
  }

  static bool isLocalhost(Uri uri) {
    List<String> localhostAddress = <String>['localhost', '127.0.0.1', '0.0.0.0'];

    if (localhostAddress.contains(uri.host)) {
      return true;
    }
    return false;
  }

  static bool compareUrisByUrn(Uri? uri1, Uri? uri2) {
    String urn1 = removeScheme(uri1.toString());
    String urn2 = removeScheme(uri2.toString());
    return urn1 == urn2;
  }

  static String removeScheme(String uri) {
    if (uri.contains('//')) {
      return uri.split('//')[1];
    } else {
      return uri;
    }
  }

  static bool shouldUseProxy({required Uri serverUri, required Uri? proxyServerUri, required Uri appUri}) {
    bool requiredSchemeExistsBool = appUri.isScheme('https') && serverUri.isScheme('http');
    bool proxyUrlExistsBool = proxyServerUri != null;
    bool localhostServerBool = isLocalhost(serverUri);

    bool useProxyBool = requiredSchemeExistsBool && proxyUrlExistsBool && (localhostServerBool == false);
    return useProxyBool;
  }

  static Uri _assignDefaultPort(Uri uri) {
    List<int> ignoredPorts = <int>[0, 80, 443];

    // If uri is domain name, then return uri without changes, because domains don't have ports
    // If uri is localhost address, then return uri without changes, because user specifies port
    if (!_isIpAddress(uri) || isLocalhost(uri)) {
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
}
