import 'package:get_it/get_it.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/infra/services/api/dashboard_service.dart';
import 'package:miro/infra/services/api/deposits_service.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/infra/services/api/withdraws_service.dart';
import 'package:miro/infra/services/api_cosmos/query_account_service.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/infra/services/api_cosmos/transactions_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/menu_provider.dart';
import 'package:miro/providers/tokens_provider.dart';
import 'package:miro/providers/wallet_provider.dart';

final GetIt globalLocator = GetIt.I;

Future<void> initLocator() async {
  globalLocator
    ..registerLazySingleton<AppConfig>(() => AppConfig())
    ..registerLazySingleton<AppConfigProvider>(() => AppConfigProviderImpl())
    ..registerLazySingleton<WalletProvider>(() => WalletProvider())
    ..registerLazySingleton<TokensProvider>(() => TokensProvider())
    ..registerLazySingleton<MenuProvider>(() => MenuProvider())
    ..registerLazySingleton<CacheManager>(() => CacheManager())
    ..registerLazySingleton<NetworkListCubit>(() => NetworkListCubit())
    ..registerLazySingleton<NetworkModuleBloc>(() => NetworkModuleBloc())
    ..registerFactory<ApiRepository>(() => RemoteApiRepository())
    ..registerFactory<ApiCosmosRepository>(() => RemoteApiCosmosRepository())
    ..registerFactory<ApiKiraRepository>(() => RemoteApiKiraRepository())
    ..registerFactory<WithdrawsService>(() => WithdrawsService())
    ..registerFactory<DashboardService>(() => DashboardService())
    ..registerFactory<QueryAccountService>(() => QueryAccountService())
    ..registerFactory<NetworkModuleService>(() => NetworkModuleService())
    ..registerFactory<DepositsService>(() => DepositsService())
    ..registerFactory<QueryValidatorsService>(() => QueryValidatorsService())
    ..registerFactory<TransactionsService>(() => TransactionsService())
    ..registerFactory<QueryKiraTokensRatesService>(() => QueryKiraTokensRatesService())
    ..registerFactory<QueryKiraTokensAliasesService>(() => QueryKiraTokensAliasesService())
    ..registerFactory<QueryInterxStatusService>(() => QueryInterxStatusService())
    ..registerFactory<QueryBalanceService>(() => QueryBalanceService());
}
