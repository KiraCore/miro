import 'package:miro/shared/controllers/browser/browser_controller.dart';

class BrowserUrlController {
  const BrowserUrlController();

  Uri get uri {
    return Uri.base;
  }

  set uri(Uri uri) {
    BrowserController.replaceUrl(uri);
  }

  Map<String, dynamic> get queryParameters {
    return Map<String, dynamic>.from(uri.queryParameters);
  }

  set queryParameters(Map<String, dynamic> queryParameters) {
    uri = uri.replace(queryParameters: queryParameters);
  }
}
