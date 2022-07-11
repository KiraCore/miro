import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/p2p_list/node.dart';
import 'package:miro/infra/dto/api/p2p_list/p2p_list_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/infra/services/geolocation_db/geolocation_db_service.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/network_visualiser/node_localization.dart';
import 'package:miro/shared/models/network_visualiser/node_model.dart';

abstract class _IP2PListService {
  Future<P2PListResp> getPubP2PListResp({Uri? optionalNetworkUri});

  Future<P2PListResp> getPrivP2PListResp({Uri? optionalNetworkUri});
}

class P2PListService implements _IP2PListService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  Future<List<NodeModel>> getPubNodes({Uri? optionalNetworkUri}) async {
    final P2PListResp p2pListResp = await getPubP2PListResp(optionalNetworkUri: optionalNetworkUri);
    List<NodeModel> nodeModels = List<NodeModel>.empty(growable: true);
    for (Node node in p2pListResp.nodeList) {
      NodeLocalization nodeLocalization = await globalLocator<GeolocationDbService>().getNodeLocalization(node.ip);
      NodeModel nodeModel = NodeModel.fromDto(node, nodeLocalization);
      nodeModels.add(nodeModel);
    }
    return nodeModels;
  }

  @override
  Future<P2PListResp> getPubP2PListResp({Uri? optionalNetworkUri}) async {
    final Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    Response<dynamic> response = await _apiRepository.fetchPubP2PList<dynamic>(networkUri);
    return P2PListResp.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<P2PListResp> getPrivP2PListResp({Uri? optionalNetworkUri}) async {
    final Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    Response<dynamic> response = await _apiRepository.fetchPrivP2PList<dynamic>(networkUri);
    return P2PListResp.fromJson(response.data as Map<String, dynamic>);
  }
}
