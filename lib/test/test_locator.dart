import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/infra/services/api/dashboard_service.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/test/mock_api_cosmos_repository.dart';
import 'package:miro/test/mock_api_kira_repository.dart';
import 'package:miro/test/mock_api_repository.dart';
import 'package:miro/test/mocks/mock_network_list_config.json.dart';

Future<void> initTestLocator() async {
  globalLocator
    ..registerLazySingleton<AppConfig>(() => AppConfig())
    ..registerLazySingleton<AppConfigProvider>(() => AppConfigProviderImpl())
    ..registerLazySingleton<WalletProvider>(() => WalletProvider())
    ..registerLazySingleton<TokensProvider>(() => TokensProvider())
    ..registerLazySingleton<CacheManager>(() => CacheManager())
    ..registerLazySingleton<NetworkModuleBloc>(() => NetworkModuleBloc())
    ..registerLazySingleton<NetworkListCubit>(() => NetworkListCubit())
    ..registerLazySingleton<ApiRepository>(() => MockApiRepository())
    ..registerFactory<ApiKiraRepository>(() => MockApiKiraRepository())
    ..registerFactory<ApiCosmosRepository>(() => MockApiCosmosRepository())
    ..registerFactory<NetworkModuleService>(() => NetworkModuleService())
    ..registerFactory<QueryInterxStatusService>(() => QueryInterxStatusService())
    ..registerFactory<QueryBalanceService>(() => QueryBalanceService())
    ..registerFactory<DashboardService>(() => DashboardService())
    ..registerFactory<QueryKiraTokensRatesService>(() => QueryKiraTokensRatesService())
    ..registerFactory<QueryKiraTokensAliasesService>(() => QueryKiraTokensAliasesService())
    ..registerFactory<QueryValidatorsService>(() => QueryValidatorsService());

  globalLocator<AppConfig>().init(mockNetworkListConfigJson);
}
