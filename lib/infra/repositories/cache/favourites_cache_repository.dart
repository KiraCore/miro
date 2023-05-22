import 'dart:convert';

import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/cache/cache_entry_key.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';

/// Current architecture of FavouritesCacheRepository:
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
class FavouritesCacheRepository {
  static const CacheEntryKey _cacheEntryKey = CacheEntryKey.favourites;
  final ICacheManager _cacheManager;

  FavouritesCacheRepository({
    ICacheManager? cacheManager,
  }) : _cacheManager = cacheManager ?? globalLocator<ICacheManager>();

  Future<void> add(String domainName, String favouriteId) async {
    Set<String> favouritesIds = getAll(domainName)..add(favouriteId);
    await _saveInCache(domainName, favouritesIds);
  }

  Future<void> delete(String domainName, String favouriteId) async {
    Set<String> values = getAll(domainName)..removeWhere((String e) => e == favouriteId);
    await _saveInCache(domainName, values);
  }

  Set<String> getAll(String domainName) {
    String result = _cacheManager.get<String>(
      boxName: _cacheEntryKey.name,
      key: domainName,
      defaultValue: '',
    );
    if (result.isEmpty) {
      return <String>{};
    } else {
      return (jsonDecode(result) as List<dynamic>).cast<String>().toSet();
    }
  }

  // Save values as a [List] converted to [String] because [Set] is not a json encodable object
  Future<void> _saveInCache(String domainName, Set<String> values) async {
    await _cacheManager.add<String>(
      boxName: _cacheEntryKey.name,
      key: domainName,
      value: jsonEncode(values.toList()),
    );
  }
}
