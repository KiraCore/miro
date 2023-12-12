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
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/mocks/mock_network_list_config_json.dart';

class TestUtils {
  // @formatter:off
  static final Mnemonic mnemonic = Mnemonic(value: 'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield');
  static final Wallet wallet = Wallet.derive(mnemonic: mnemonic);
  // @formatter:on

  static TokenAliasModel btcTokenAliasModel = const TokenAliasModel(
    name: 'Bitcoin',
    lowestTokenDenominationModel: TokenDenominationModel(name: 'satoshi', decimals: 0),
    defaultTokenDenominationModel: TokenDenominationModel(name: 'BTC', decimals: 8),
  );

  static TokenAliasModel ethTokenAliasModel = const TokenAliasModel(
    name: 'Ethereum',
    lowestTokenDenominationModel: TokenDenominationModel(name: 'wei', decimals: 0),
    defaultTokenDenominationModel: TokenDenominationModel(name: 'ETH', decimals: 18),
  );

  static TokenAliasModel kexTokenAliasModel = const TokenAliasModel(
    name: 'Kira',
    lowestTokenDenominationModel: TokenDenominationModel(name: 'ukex', decimals: 0),
    defaultTokenDenominationModel: TokenDenominationModel(name: 'KEX', decimals: 6),
  );

  static TokenAliasModel derivedKexTokenAliasModel = const TokenAliasModel(
    name: 'v1/Kira',
    lowestTokenDenominationModel: TokenDenominationModel(name: 'v1/ukex', decimals: 0),
  );

  static final NetworkUnknownModel healthyNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://healthy.kira.network'),
    name: 'healthy-mainnet',
  );

  static final NetworkUnknownModel unhealthyNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://unhealthy.kira.network'),
    name: 'unhealthy-mainnet',
  );

  static final NetworkUnknownModel offlineNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://offline.kira.network'),
    name: 'offline-mainnet',
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
  );

  static final NetworkOfflineModel networkOfflineModel = NetworkOfflineModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    name: 'offline-mainnet',
    uri: Uri.parse('https://offline.kira.network'),
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
    interxWarningModel: const InterxWarningModel(<InterxWarningType>[
      InterxWarningType.versionOutdated,
      InterxWarningType.blockTimeOutdated,
    ]),
  );

  static Future<void> initIntegrationTest() async {
    await initLocator();
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
    );

    globalLocator<NetworkModuleBloc>().add(NetworkModuleConnectEvent(mockNetworkHealthyModel));
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}
