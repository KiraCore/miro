import 'package:hive_flutter/adapters.dart';
import 'package:miro/infra/managers/cache/cache_entry_key.dart';
import 'package:miro/infra/repositories/cache/api_cache_repository.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  await Hive.openBox<String>(ApiCacheRepository.boxName);
  await Hive.openBox<String>(CacheEntryKey.favourites.name);
}
