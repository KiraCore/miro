import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/managers/cache/i_cache_manager.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mocks/mock_network_list_config_json.dart';

class TestUtils {
  static Wallet wallet = Wallet(
    address: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
    ecPrivateKey: ECPrivateKey(
      CurvePoints.generatorSecp256k1,
      BigInt.parse('25933686250415448129536663355227060923413846494721047098076326567395973050293'),
    ),
  );

  static DateTime defaultLastRefreshDateTime = DateTime(2024, 3, 14, 14, 17);

  static TokenAliasModel btcTokenAliasModel = const TokenAliasModel(
    name: 'Bitcoin',
    defaultTokenDenominationModel: TokenDenominationModel(name: 'satoshi', decimals: 0),
    networkTokenDenominationModel: TokenDenominationModel(name: 'BTC', decimals: 8),
  );

  static TokenAliasModel ethTokenAliasModel = const TokenAliasModel(
    name: 'Ethereum',
    defaultTokenDenominationModel: TokenDenominationModel(name: 'wei', decimals: 0),
    networkTokenDenominationModel: TokenDenominationModel(name: 'ETH', decimals: 18),
  );

  static TokenAliasModel kexTokenAliasModel = const TokenAliasModel(
    name: 'Kira',
    defaultTokenDenominationModel: TokenDenominationModel(name: 'ukex', decimals: 0),
    networkTokenDenominationModel: TokenDenominationModel(name: 'KEX', decimals: 6),
  );

  static TokenAliasModel derivedKexTokenAliasModel = const TokenAliasModel(
    name: 'v1/Kira',
    defaultTokenDenominationModel: TokenDenominationModel(name: 'v1/ukex', decimals: 0),
  );

  static final NetworkUnknownModel healthyNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://healthy.kira.network'),
    name: 'healthy-mainnet',
    lastRefreshDateTime: defaultLastRefreshDateTime,
  );

  static final NetworkUnknownModel unhealthyNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://unhealthy.kira.network'),
    name: 'unhealthy-mainnet',
    lastRefreshDateTime: defaultLastRefreshDateTime,
  );

  static final NetworkUnknownModel offlineNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://offline.kira.network'),
    name: 'offline-mainnet',
    lastRefreshDateTime: defaultLastRefreshDateTime,
  );

  static final NetworkHealthyModel networkHealthyModel = NetworkHealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://healthy.kira.network'),
    name: 'healthy-mainnet',
    networkInfoModel: NetworkInfoModel(
      chainId: 'localnet-1',
      interxVersion: 'v0.4.22',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.now(),
      activeValidators: 319,
      totalValidators: 475,
    ),
    tokenDefaultDenomModel: TokenDefaultDenomModel(
      valuesFromNetworkExistBool: true,
      bech32AddressPrefix: 'kira',
      defaultTokenAliasModel: TokenAliasModel.local('ukex'),
    ),
    lastRefreshDateTime: defaultLastRefreshDateTime,
  );

  static final NetworkUnhealthyModel networkUnhealthyModel = NetworkUnhealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://unhealthy.kira.network'),
    name: 'unhealthy-mainnet',
    interxWarningModel: const InterxWarningModel(<InterxWarningType>[
      InterxWarningType.versionOutdated,
      InterxWarningType.blockTimeOutdated,
    ]),
    networkInfoModel: NetworkInfoModel(
      chainId: 'testnet-7',
      interxVersion: 'v0.7.0.4',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.parse('2021-11-04 12:42:54.395Z'),
    ),
    tokenDefaultDenomModel: TokenDefaultDenomModel(
      valuesFromNetworkExistBool: true,
      bech32AddressPrefix: 'kira',
      defaultTokenAliasModel: TokenAliasModel.local('ukex'),
    ),
    lastRefreshDateTime: defaultLastRefreshDateTime,
  );

  static final NetworkOfflineModel initialNetworkOfflineModel = NetworkOfflineModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    name: 'offline-mainnet',
    uri: Uri.parse('https://offline.kira.network'),
    lastRefreshDateTime: defaultLastRefreshDateTime,
  );

  static final NetworkOfflineModel networkOfflineModel = NetworkOfflineModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    name: 'offline-mainnet',
    uri: Uri.parse('https://offline.kira.network'),
    lastRefreshDateTime: defaultLastRefreshDateTime,
  );

  static final NetworkHealthyModel customNetworkHealthyModel = NetworkHealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://custom-healthy.kira.network'),
    networkInfoModel: NetworkInfoModel(
      chainId: 'localnet-1',
      interxVersion: 'v0.4.22',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.now(),
      activeValidators: 319,
      totalValidators: 475,
    ),
    tokenDefaultDenomModel: TokenDefaultDenomModel(
      valuesFromNetworkExistBool: true,
      bech32AddressPrefix: 'kira',
      defaultTokenAliasModel: TokenAliasModel.local('ukex'),
    ),
    lastRefreshDateTime: defaultLastRefreshDateTime,
  );

  static final NetworkUnhealthyModel customNetworkUnhealthyModel = NetworkUnhealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://custom-unhealthy.kira.network'),
    networkInfoModel: NetworkInfoModel(
      chainId: 'testnet-7',
      interxVersion: 'v0.7.0.4',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.parse('2021-11-04T12:42:54.394946399Z'),
      activeValidators: 319,
      totalValidators: 475,
    ),
    tokenDefaultDenomModel: TokenDefaultDenomModel(
      valuesFromNetworkExistBool: true,
      bech32AddressPrefix: 'kira',
      defaultTokenAliasModel: TokenAliasModel.local('ukex'),
    ),
    interxWarningModel: const InterxWarningModel(<InterxWarningType>[
      InterxWarningType.versionOutdated,
      InterxWarningType.blockTimeOutdated,
    ]),
    lastRefreshDateTime: defaultLastRefreshDateTime,
  );

  static Object? catchException(Function() function) {
    try {
      function();
      return null;
    } catch (e) {
      return e;
    }
  }

  static Future<void> initIntegrationTest() async {
    initLocator();
    await globalLocator<ICacheManager>().init();
    globalLocator<AppConfig>().init(MockNetworkListConfigJson.defaultNetworkListConfig);
  }

  static void printInfo(String message) {
    // ignore: avoid_print
    print('\x1B[34m$message\x1B[0m');
  }

  static void printError(String message) {
    // ignore: avoid_print
    print('\x1B[31m$message\x1B[0m');
  }

  static Future<void> setupNetworkModel({required Uri networkUri}) async {
    NetworkHealthyModel mockNetworkHealthyModel = NetworkHealthyModel(
      connectionStatusType: ConnectionStatusType.disconnected,
      uri: networkUri,
      networkInfoModel: NetworkInfoModel(
        chainId: 'test',
        interxVersion: 'test',
        latestBlockHeight: 0,
        latestBlockTime: DateTime.now(),
      ),
      tokenDefaultDenomModel: TokenDefaultDenomModel(
        valuesFromNetworkExistBool: true,
        bech32AddressPrefix: 'kira',
        defaultTokenAliasModel: TokenAliasModel.local('ukex'),
      ),
      lastRefreshDateTime: defaultLastRefreshDateTime,
    );

    globalLocator<NetworkModuleBloc>().add(NetworkModuleConnectEvent(mockNetworkHealthyModel));
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}
