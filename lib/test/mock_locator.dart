import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/network_list/network_custom_section/network_custom_section_cubit.dart';
import 'package:miro/blocs/widgets/network_list/network_list/network_list_cubit.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
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
import 'package:miro/shared/controllers/reload_notifier/reload_notifier_controller.dart';
import 'package:miro/test/mock_api_kira_repository.dart';
import 'package:miro/test/mock_api_repository.dart';
import 'package:miro/test/mock_app_config.dart';
import 'package:miro/test/mocks/mock_network_list_config_json.dart';

Future<void> initMockLocator() async {
  globalLocator
    ..registerLazySingleton<AppConfig>(MockAppConfig.buildDefaultConfig)
    ..registerLazySingleton<AppConfigProvider>(AppConfigProviderImpl.new)
    ..registerLazySingleton<NetworkCustomSectionCubit>(NetworkCustomSectionCubit.new)
    ..registerLazySingleton<AuthCubit>(AuthCubit.new)
    ..registerLazySingleton<CacheManager>(CacheManager.new)
    ..registerLazySingleton<QueryAccountService>(QueryAccountService.new)
    ..registerLazySingleton<NetworkModuleBloc>(NetworkModuleBloc.new)
    ..registerLazySingleton<NetworkListCubit>(NetworkListCubit.new)
    ..registerLazySingleton<IApiRepository>(MockApiRepository.new)
    ..registerLazySingleton<IApiKiraRepository>(MockApiKiraRepository.new)
    ..registerLazySingleton<QueryExecutionFeeService>(QueryExecutionFeeService.new)
    ..registerFactory<NetworkModuleService>(NetworkModuleService.new)
    ..registerFactory<QueryInterxStatusService>(QueryInterxStatusService.new)
    ..registerFactory<QueryBalanceService>(QueryBalanceService.new)
    ..registerLazySingleton<QueryNetworkPropertiesService>(QueryNetworkPropertiesService.new)
    ..registerFactory<DashboardService>(DashboardService.new)
    ..registerFactory<QueryKiraTokensRatesService>(QueryKiraTokensRatesService.new)
    ..registerFactory<QueryKiraTokensAliasesService>(QueryKiraTokensAliasesService.new)
    ..registerFactory<QueryValidatorsService>(QueryValidatorsService.new)
    ..registerLazySingleton<ReloadNotifierController>(ReloadNotifierController.new)
    ..registerLazySingleton<BroadcastService>(BroadcastService.new);

  globalLocator<AppConfig>().init(MockNetworkListConfigJson.defaultNetworkListConfig);
}
