import 'package:hive_flutter/adapters.dart';
import 'package:miro/blocs/specific_blocs/lists/balance_list_bloc.dart';
import 'package:miro/infra/cache/api_cache/cached_response.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CachedResponseAdapter());

  await Hive.openBox<String>('configuration');
  await Hive.openBox<CachedResponse>('request_cache');
  await Hive.openBox<bool>(BalanceListBloc.favouriteCacheWorkspace);
}
