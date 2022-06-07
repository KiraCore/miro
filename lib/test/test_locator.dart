import 'package:miro/blocs/specific_blocs/network/network_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/network/i_network_list_loader.dart';
import 'package:miro/config/network/test_network_list_loader.dart';
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
import 'package:miro/infra/services/network_utils_service.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/test/mock_api_cosmos_repository.dart';
import 'package:miro/test/mock_api_kira_repository.dart';
import 'package:miro/test/mock_api_repository.dart';

Future<void> initTestLocator() async {
  globalLocator
    ..registerLazySingleton<AppConfigProvider>(() => AppConfigProviderImpl())
    ..registerLazySingleton<WalletProvider>(() => WalletProvider())
    ..registerLazySingleton<TokensProvider>(() => TokensProvider())
    ..registerLazySingleton<CacheManager>(() => CacheManager())
    ..registerLazySingleton<NetworkBloc>(() => NetworkBloc())
    ..registerFactory<ApiKiraRepository>(() => MockApiKiraRepository())
    ..registerFactory<ApiRepository>(() => MockApiRepository())
    ..registerFactory<INetworkListLoader>(() => TestNetworkListLoader())
    ..registerFactory<ApiCosmosRepository>(() => MockApiCosmosRepository())
    ..registerFactory<NetworkUtilsService>(() => NetworkUtilsService())
    ..registerFactory<QueryInterxStatusService>(() => QueryInterxStatusService())
    ..registerFactory<QueryBalanceService>(() => QueryBalanceService())
    ..registerFactory<DashboardService>(() => DashboardService())
    ..registerFactory<QueryKiraTokensRatesService>(() => QueryKiraTokensRatesService())
    ..registerFactory<QueryKiraTokensAliasesService>(() => QueryKiraTokensAliasesService())
    ..registerFactory<QueryValidatorsService>(() => QueryValidatorsService());
}
