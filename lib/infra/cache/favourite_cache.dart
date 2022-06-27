import 'dart:convert';

import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';

/// Current architecture of FavouriteCache:
/// hiveKey {
///   fav_key_1: [favId_1.1, favId_1.2, favId_1.3]
///   fav_key_2: [favId_2.1, favId_2.2, favId_3.3]
/// }
///
/// Example:
/// favourites {
///   validators: ['kira12p8c7ynv7uxzdd88dc9trd9e4qzsewjvqq8y2x', 'kira1mpqwqe3zhejalh9zveumy3uduess5p8n09wjmh'],
///   balances: ['ukex', 'samolean'],
/// }
class FavouriteCache {
  static const String hiveKey = 'favourites';
  final String key;
  final CacheManager _cacheManager = globalLocator<CacheManager>();

  FavouriteCache({
    required this.key,
  });

  void add(String value) {
    Set<String> values = getAll()..add(value);
    _saveInCache(values);
  }

  void delete(String value) {
    Set<String> values = getAll()..removeWhere((String e) => e == value);
    _saveInCache(values);
  }

  Set<String> getAll() {
    String result = _cacheManager.get<String>(
      boxName: hiveKey,
      key: key,
      defaultValue: '',
    );
    if (result.isEmpty) {
      return <String>{};
    } else {
      return (jsonDecode(result) as List<dynamic>).cast<String>().toSet();
    }
  }

  // Save values as List because Set is not an json encodable object
  void _saveInCache(Set<String> values) {
    _cacheManager.add<String>(boxName: hiveKey, key: key, value: jsonEncode(values.toList()));
  }
}
