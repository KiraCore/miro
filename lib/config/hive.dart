import 'package:hive_flutter/adapters.dart';
import 'package:miro/blocs/specific_blocs/lists/balance_list_bloc.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  await Hive.openBox<String>('configuration');
  await Hive.openBox<bool>(BalanceListBloc.favouriteCacheWorkspace);
}
