import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';

class TestUtils {
  static final NetworkUnknownModel offlineNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://offline.kira.network'),
    name: 'offline-mainnet',
  );

  static final NetworkOfflineModel networkOfflineModel = NetworkOfflineModel(
    connectionStatusType: ConnectionStatusType.connected,
    name: 'offline-mainnet',
    uri: Uri.parse('https://offline.kira.network'),
  );

  static final NetworkHealthyModel networkHealthyModel = NetworkHealthyModel(
    connectionStatusType: ConnectionStatusType.connected,
    uri: Uri.parse('https://healthy.kira.network'),
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

  static final NetworkHealthyModel customNetworkHealthyModel = NetworkHealthyModel(
    connectionStatusType: ConnectionStatusType.connected,
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
    connectionStatusType: ConnectionStatusType.connected,
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
