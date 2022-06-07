import 'package:miro/shared/controllers/browser/browser_url_controller.dart';

class MockBrowserUrlController extends BrowserUrlController {
  Uri mockedUri;

  MockBrowserUrlController({
    required this.mockedUri,
  });

  @override
  Uri get uri {
    return mockedUri;
  }

  @override
  set uri(Uri uri) {
    mockedUri = uri;
  }
}
