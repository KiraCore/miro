import 'package:hive/hive.dart';

class AppConfigCache {
  final Box<String> cache = Hive.box<String>('configuration');

  String? getConfig(String key, {String? defaultValue}) {
    return cache.get(key, defaultValue: defaultValue);
  }

  void updateConfig(String key, String? value) {
    if (value == null) {
      cache.delete(key);
    } else {
      cache.put(key, value);
    }
  }
}
