import 'package:get_it/get_it.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/infra/services/api/deposits_service.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/withdraws_service.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/providers/wallet_provider.dart';

final GetIt globalLocator = GetIt.I;

Future<void> initLocator() async {
  globalLocator
    ..registerLazySingleton<AppConfigProvider>(() => AppConfigProviderImpl())
    ..registerLazySingleton<NetworkProvider>(() => NetworkProvider())
    ..registerLazySingleton<WalletProvider>(() => WalletProvider())
    ..registerFactory<ApiRepository>(() => RemoteApiRepository())
    ..registerFactory<ApiCosmosRepository>(() => RemoteApiCosmosRepository())
    ..registerFactory<WithdrawsService>(() => WithdrawsService())
    ..registerFactory<DepositsService>(() => DepositsService())
    ..registerFactory<QueryInterxStatusService>(() => QueryInterxStatusService())
    ..registerFactory<QueryBalanceService>(() => QueryBalanceService());
}
