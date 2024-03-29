import 'package:miro/config/app_config.dart';
import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';

class MockAppConfig extends AppConfig {
  MockAppConfig({
    required int bulkSinglePageSize,
    required Duration outdatedBlockDuration,
    required Duration defaultApiCacheMaxAge,
    required Duration loadingPageTimerDuration,
    required List<String> supportedInterxVersions,
    required RpcBrowserUrlController rpcBrowserUrlController,
    required int defaultRefreshIntervalSeconds,
  }) : super(
          bulkSinglePageSize: bulkSinglePageSize,
          defaultApiCacheMaxAge: defaultApiCacheMaxAge,
          outdatedBlockDuration: outdatedBlockDuration,
          loadingPageTimerDuration: loadingPageTimerDuration,
          supportedInterxVersions: supportedInterxVersions,
          rpcBrowserUrlController: rpcBrowserUrlController,
          defaultRefreshIntervalSeconds: defaultRefreshIntervalSeconds,
        );

  factory MockAppConfig.buildDefaultConfig() {
    return MockAppConfig(
      bulkSinglePageSize: 500,
      defaultApiCacheMaxAge: const Duration(seconds: 60),
      outdatedBlockDuration: const Duration(minutes: 5),
      loadingPageTimerDuration: const Duration(seconds: 4),
      supportedInterxVersions: <String>['v0.4.22'],
      rpcBrowserUrlController: RpcBrowserUrlController(),
      defaultRefreshIntervalSeconds: 60,
    );
  }
}
