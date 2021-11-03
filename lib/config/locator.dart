import 'package:get_it/get_it.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/infra/services/interx_status_service.dart';
import 'package:miro/providers/app_config_provider.dart';
import 'package:miro/providers/network_provider.dart';

final GetIt globalLocator = GetIt.I;

Future<void> initLocator() async {
  globalLocator
    ..registerLazySingleton<AppConfigProvider>(() => AppConfigProviderImpl())
    ..registerLazySingleton(() => NetworkProvider())
    ..registerFactory<ApiRepository>(() => RemoteApiRepository())
    ..registerFactory<InterxStatusService>(() => InterxStatusService());
}
