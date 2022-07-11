import 'package:flutter/services.dart';

class GeoJsonAsset {
  static Future<String> world() {
    return rootBundle.loadString('assets/world.json');
  }
}
