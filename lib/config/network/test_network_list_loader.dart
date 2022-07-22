import 'package:miro/config/network/i_network_list_loader.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';

class TestNetworkListLoader implements INetworkListLoader {
  @override
  Future<List<NetworkUnknownModel>> loadNetworkListConfig() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return <NetworkUnknownModel>[
      NetworkUnknownModel(uri: Uri.parse('https://healthy.kira.network/')),
      NetworkUnknownModel(uri: Uri.parse('https://online.kira.network/')),
      NetworkUnknownModel(uri: Uri.parse('https://offline.kira.network/'))
    ];
  }
}
