import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/identity_registrar/identity_registrar_cubit.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/layout/drawer/drawer_cubit.dart';
import 'package:miro/blocs/layout/nav_menu/nav_menu_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_list/network_list_cubit.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/cache/api_cache_manager.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/infra/managers/cache/impl/memory_cache_manager.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/infra/repositories/cache/api_cache_repository.dart';
import 'package:miro/infra/services/api/dashboard_service.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_transactions_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/infra/services/api_kira/broadcast_service.dart';
import 'package:miro/infra/services/api_kira/identity_records_service.dart';
import 'package:miro/infra/services/api_kira/query_account_service.dart';
import 'package:miro/infra/services/api_kira/query_balance_service.dart';
import 'package:miro/infra/services/api_kira/query_delegations_service.dart';
import 'package:miro/infra/services/api_kira/query_execution_fee_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/infra/services/api_kira/query_network_properties_service.dart';
import 'package:miro/infra/services/api_kira/query_staking_pool_service.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/test/mock_api_kira_repository.dart';
import 'package:miro/test/mock_api_repository.dart';
import 'package:miro/test/mock_app_config.dart';
import 'package:miro/test/mocks/mock_network_list_config_json.dart';

Future<void> initMockLocator() async {
  globalLocator
    ..registerLazySingleton<AppConfig>(MockAppConfig.buildDefaultConfig)
    ..registerLazySingleton<ICacheManager>(MemoryCacheManager.new);

  _initRepositories();
  _initServices();
  _initControllers();

  globalLocator<AppConfig>().init(MockNetworkListConfigJson.defaultNetworkListConfig);
  await globalLocator<IdentityRegistrarCubit>().refresh();
}

void _initRepositories() {
  globalLocator
    ..registerLazySingleton<ApiCacheRepository>(ApiCacheRepository.new)
    ..registerLazySingleton<IApiKiraRepository>(MockApiKiraRepository.new)
    ..registerLazySingleton<IApiRepository>(MockApiRepository.new);
}

void _initServices() {
  globalLocator
    ..registerLazySingleton<ApiCacheManager>(ApiCacheManager.new)
    ..registerLazySingleton<BroadcastService>(BroadcastService.new)
    ..registerLazySingleton<DashboardService>(DashboardService.new)
    ..registerLazySingleton<IdentityRecordsService>(IdentityRecordsService.new)
    ..registerLazySingleton<NetworkModuleService>(NetworkModuleService.new)
    ..registerLazySingleton<QueryAccountService>(QueryAccountService.new)
    ..registerLazySingleton<QueryBalanceService>(QueryBalanceService.new)
    ..registerLazySingleton<QueryDelegationsService>(QueryDelegationsService.new)
    ..registerLazySingleton<QueryExecutionFeeService>(QueryExecutionFeeService.new)
    ..registerLazySingleton<QueryInterxStatusService>(QueryInterxStatusService.new)
    ..registerLazySingleton<QueryKiraTokensAliasesService>(QueryKiraTokensAliasesService.new)
    ..registerLazySingleton<QueryKiraTokensRatesService>(QueryKiraTokensRatesService.new)
    ..registerLazySingleton<QueryNetworkPropertiesService>(QueryNetworkPropertiesService.new)
    ..registerLazySingleton<QueryStakingPoolService>(QueryStakingPoolService.new)
    ..registerLazySingleton<QueryTransactionsService>(QueryTransactionsService.new)
    ..registerLazySingleton<QueryValidatorsService>(QueryValidatorsService.new);
}

void _initControllers() {
  globalLocator
    ..registerLazySingleton<AuthCubit>(AuthCubit.new)
    ..registerLazySingleton<DrawerCubit>(DrawerCubit.new)
    ..registerLazySingleton<IdentityRegistrarCubit>(IdentityRegistrarCubit.new)
    ..registerLazySingleton<NavMenuCubit>(NavMenuCubit.new)
    ..registerLazySingleton<NetworkCustomSectionCubit>(NetworkCustomSectionCubit.new)
    ..registerLazySingleton<NetworkListCubit>(NetworkListCubit.new)
    ..registerLazySingleton<NetworkModuleBloc>(NetworkModuleBloc.new);
}
