import 'package:get_it/get_it.dart';
import 'package:miro/blocs/specific_blocs/nav_menu/nav_menu_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/infra/cache/cache_manager.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/infra/services/api/dashboard_service.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/infra/services/api_kira/broadcast_service.dart';
import 'package:miro/infra/services/api_kira/query_account_service.dart';
import 'package:miro/infra/services/api_kira/query_balance_service.dart';
import 'package:miro/infra/services/api_kira/query_execution_fee_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/infra/services/api_kira/query_network_properties_service.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/wallet_provider.dart';
import 'package:miro/shared/controllers/reload_notifier/reload_notifier_controller.dart';

final GetIt globalLocator = GetIt.I;

Future<void> initLocator() async {
  globalLocator
    ..registerLazySingleton<AppConfig>(AppConfig.new)
    ..registerLazySingleton<AppConfigProvider>(AppConfigProviderImpl.new)
    ..registerLazySingleton<WalletProvider>(WalletProvider.new)
    ..registerLazySingleton<NavMenuCubit>(NavMenuCubit.new)
    ..registerLazySingleton<CacheManager>(CacheManager.new)
    ..registerLazySingleton<NetworkListCubit>(NetworkListCubit.new)
    ..registerLazySingleton<NetworkModuleBloc>(NetworkModuleBloc.new)
    ..registerLazySingleton<QueryExecutionFeeService>(QueryExecutionFeeService.new)
    ..registerFactory<ApiRepository>(RemoteApiRepository.new)
    ..registerFactory<ApiKiraRepository>(RemoteApiKiraRepository.new)
    ..registerFactory<DashboardService>(DashboardService.new)
    ..registerFactory<QueryAccountService>(QueryAccountService.new)
    ..registerFactory<NetworkModuleService>(NetworkModuleService.new)
    ..registerFactory<QueryValidatorsService>(QueryValidatorsService.new)
    ..registerLazySingleton<BroadcastService>(BroadcastService.new)
    ..registerLazySingleton<QueryNetworkPropertiesService>(QueryNetworkPropertiesService.new)
    ..registerFactory<QueryKiraTokensRatesService>(QueryKiraTokensRatesService.new)
    ..registerFactory<QueryKiraTokensAliasesService>(QueryKiraTokensAliasesService.new)
    ..registerFactory<QueryInterxStatusService>(QueryInterxStatusService.new)
    ..registerFactory<QueryBalanceService>(QueryBalanceService.new)
    ..registerLazySingleton<ReloadNotifierController>(ReloadNotifierController.new);
}
