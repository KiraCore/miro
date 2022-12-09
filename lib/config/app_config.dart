import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/network_utils.dart';

class AppConfig {
  final RpcBrowserUrlController rpcBrowserUrlController = RpcBrowserUrlController();
  final int bulkSinglePageSize = 500;
  final TokenAliasModel defaultFeeTokenAliasModel = const TokenAliasModel(
    name: 'Kira',
    lowestTokenDenominationModel: TokenDenominationModel(name: 'ukex', decimals: 0),
    defaultTokenDenominationModel: TokenDenominationModel(name: 'KEX', decimals: 6),
  );

  final Duration outdatedBlockDuration = const Duration(minutes: 5);
  final Duration loadingPageTimerDuration = const Duration(seconds: 4);
  final List<String> supportedInterxVersions = <String>['v0.4.20-rc2', 'v0.4.20-rc3'];

  final int _defaultRefreshIntervalSeconds = 60;
  final NetworkUnknownModel _defaultNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://testnet-rpc.kira.network'),
  );

  late Uri? proxyServerUri;
  late Duration _refreshInterval;
  late List<NetworkUnknownModel> _networkList = List<NetworkUnknownModel>.empty(growable: true);

  Duration get refreshInterval => _refreshInterval;

  List<NetworkUnknownModel> get networkList => _networkList;

  void init(Map<String, dynamic> configJson) {
    _initProxyServerUri(configJson['proxy_server_url'] as String?);
    _initIntervalSeconds(configJson['refresh_interval_seconds']);
    _initNetworkList(configJson['network_list']);
  }

  bool isInterxVersionOutdated(String version) {
    bool isVersionSupported = supportedInterxVersions.contains(version);
    if (isVersionSupported) {
      return false;
    } else {
      AppLogger().log(message: 'Interx version [$version] is not supported', logLevel: LogLevel.warning);
      return true;
    }
  }

  NetworkUnknownModel findNetworkModelInConfig(NetworkUnknownModel networkUnknownModel) {
    List<NetworkUnknownModel> matchingNetworkUnknownModels = networkList.where((NetworkUnknownModel e) => e.uri.host == networkUnknownModel.uri.host).toList();

    if (matchingNetworkUnknownModels.isEmpty) {
      return networkUnknownModel;
    }
    return matchingNetworkUnknownModels.first;
  }

  Future<NetworkUnknownModel> getDefaultNetworkUnknownModel() async {
    NetworkUnknownModel? urlNetworkUnknownModel = await _getNetworkUnknownModelFromUrl();
    if (urlNetworkUnknownModel == null) {
      return networkList.first;
    }
    return urlNetworkUnknownModel;
  }

  Future<NetworkUnknownModel?> _getNetworkUnknownModelFromUrl() async {
    String? networkAddress = rpcBrowserUrlController.getRpcAddress();
    if (networkAddress == null) {
      return null;
    }
    Uri uri = NetworkUtils.parseUrlToInterxUri(networkAddress);
    NetworkUnknownModel urlNetworkUnknownModel = NetworkUnknownModel(uri: uri, connectionStatusType: ConnectionStatusType.disconnected);
    urlNetworkUnknownModel = findNetworkModelInConfig(urlNetworkUnknownModel);
    return urlNetworkUnknownModel;
  }
  
  void _initProxyServerUri(String? proxyServerUrlText) {
    try {
      proxyServerUri = NetworkUtils.parseNoSchemeToHTTPS(proxyServerUrlText!);
    } catch (_) {
      AppLogger().log(message: 'Proxy server url is invalid: $proxyServerUrlText', logLevel: LogLevel.warning);
      proxyServerUri = null;
    }
  }

  void _initIntervalSeconds(dynamic refreshIntervalSecondsJson) {
    if (refreshIntervalSecondsJson is num && refreshIntervalSecondsJson > _defaultRefreshIntervalSeconds) {
      _refreshInterval = Duration(seconds: refreshIntervalSecondsJson.round());
    } else {
      _refreshInterval = Duration(seconds: _defaultRefreshIntervalSeconds);
    }
  }

  void _initNetworkList(dynamic networkListJson) {
    _networkList = List<NetworkUnknownModel>.empty(growable: true);
    if (networkListJson is List<dynamic>) {
      for (dynamic networkListItem in networkListJson) {
        try {
          _networkList.add(NetworkUnknownModel.fromJson(networkListItem as Map<String, dynamic>));
        } catch (_) {
          AppLogger().log(message: 'CONFIG: Cannot parse network list item from network_list_config.json: $networkListItem');
        }
      }
    }

    if (_networkList.isEmpty) {
      _networkList.add(_defaultNetworkUnknownModel);
    }
  }
}
