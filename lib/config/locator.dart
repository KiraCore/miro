import 'package:get_it/get_it.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/infra/services/api/deposits_service.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/infra/services/api/withdraws_service.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/menu_provider.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/providers/wallet_provider.dart';

final GetIt globalLocator = GetIt.I;

Future<void> initLocator() async {
  globalLocator
    ..registerLazySingleton<AppConfigProvider>(() => AppConfigProviderImpl())
    ..registerLazySingleton<NetworkProvider>(() => NetworkProvider())
    ..registerLazySingleton<WalletProvider>(() => WalletProvider())
    ..registerLazySingleton<TokensProvider>(() => TokensProvider())
    ..registerLazySingleton<MenuProvider>(() => MenuProvider())
    ..registerFactory<ApiRepository>(() => RemoteApiRepository())
    ..registerFactory<ApiCosmosRepository>(() => RemoteApiCosmosRepository())
    ..registerFactory<ApiKiraRepository>(() => RemoteApiKiraRepository())
    ..registerFactory<WithdrawsService>(() => WithdrawsService())
    ..registerFactory<DepositsService>(() => DepositsService())
    ..registerFactory<QueryValidatorsService>(() => QueryValidatorsService())
    ..registerFactory<QueryKiraTokensRatesService>(() => QueryKiraTokensRatesService())
    ..registerFactory<QueryKiraTokensAliasesService>(() => QueryKiraTokensAliasesService())
    ..registerFactory<QueryInterxStatusService>(() => QueryInterxStatusService())
    ..registerFactory<QueryBalanceService>(() => QueryBalanceService());
}
