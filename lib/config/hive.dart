import 'package:hive_flutter/adapters.dart';
import 'package:miro/infra/cache/favourite_cache.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  await Hive.openBox<String>('configuration');
  await Hive.openBox<String>(FavouriteCache.hiveKey);
}
