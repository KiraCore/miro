import 'package:miro/config/locator.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/test/mock_api_repository.dart';

Future<void> initTestLocator() async {
  globalLocator
    ..registerLazySingleton<AppConfigProvider>(() => AppConfigProviderImpl())
    ..registerLazySingleton<NetworkProvider>(() => NetworkProvider())
    ..registerFactory<ApiRepository>(() => MockApiRepository())
    ..registerFactory<QueryInterxStatusService>(() => QueryInterxStatusService())
    ..registerFactory<QueryValidatorsService>(() => QueryValidatorsService());
}
