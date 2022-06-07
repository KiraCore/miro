import 'package:miro/config/network/i_network_list_loader.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/utils/assets_manager.dart';

class NetworkListLoader implements INetworkListLoader {
  @override
  Future<List<ANetworkStatusModel>> loadNetworkListConfig() async {
    Map<String, dynamic> networkListConfigJson = await AssetsManager().getAsMap('assets/network_list_config.json');
    List<NetworkUnknownModel> configNetworkStatusModels = (networkListConfigJson['network_list'] as List<dynamic>)
        .map((dynamic e) => NetworkUnknownModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return List<ANetworkStatusModel>.empty(growable: true)..addAll(configNetworkStatusModels);
  }
}
