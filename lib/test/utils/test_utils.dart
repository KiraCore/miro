import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';

class TestUtils {
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
