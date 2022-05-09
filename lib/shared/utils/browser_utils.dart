import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

class BrowserUtils {
  static void replaceUrl(Uri newUrl) {
    html.window.history.replaceState(<String, dynamic>{}, '', newUrl.toString());
  }

  static void downloadFile(Uint8List data, String name) {
    final String content = base64Encode(data);
    final html.AnchorElement anchor =
        html.AnchorElement(href: 'data:application/octet-stream;charset=utf-16le;base64,$content')
          ..setAttribute('download', name)
          ..click();
  }
}
