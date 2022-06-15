import 'dart:convert';

import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';

class FavouriteCache {
  static const String hiveKey = 'favourites';
  final String key;
  final CacheManager _cacheManager = globalLocator<CacheManager>();

  FavouriteCache({
    required this.key,
  });

  void add(String value) {
    List<String> values = getAll()..add(value);
    addAll(values);
  }

  void addAll(List<String> values) {
    List<String> result = values.toSet().toList();
    _cacheManager.add<String>(boxName: hiveKey, key: key, value: jsonEncode(result));
  }

  void delete(String value) {
    Set<String> values = getAll().toSet()..removeWhere((String e) => e == value);
    addAll(values.toList());
  }

  void deleteAll() {
    return _cacheManager.delete<String>(boxName: hiveKey, key: key);
  }

  List<String> getAll() {
    String result = _cacheManager.get<String>(
      boxName: hiveKey,
      key: key,
      defaultValue: '',
    );
    if (result.isEmpty) {
      return List<String>.empty(growable: true);
    } else {
      return (jsonDecode(result) as List<dynamic>).cast<String>();
    }
  }

  Map<String, bool> getAllBoxes() {
    return _cacheManager.getAll<bool>(boxName: hiveKey);
  }
}
