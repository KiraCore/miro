import 'package:hive_flutter/adapters.dart';
import 'package:miro/infra/managers/cache/cache_entry_key.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  await Hive.openBox<String>(CacheEntryKey.favourites.name);
}
