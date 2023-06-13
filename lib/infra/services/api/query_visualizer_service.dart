import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_p2p/request/query_p2p_req.dart';
import 'package:miro/infra/dto/api/query_p2p/response/node.dart';
import 'package:miro/infra/dto/api/query_p2p/response/query_p2p_resp.dart';
import 'package:miro/infra/dto/interx_headers.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/infra/services/assets/country_lat_long_service.dart';
import 'package:miro/shared/models/visualizer/country_lat_long_model.dart';
import 'package:miro/shared/models/visualizer/visualizer_model.dart';
import 'package:miro/shared/models/visualizer/visualizer_node_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';
import 'package:miro/test/mocks/api/mock_api_p2p.dart';

abstract class _IQueryVisualizerService {
  Future<PageData<VisualizerNodeModel>> getVisualizerNodeModelList(QueryP2PReq queryP2PReq);
}

// TODO(Marcin): update to use actual endpoint instead of mock response after endpoint modification
class QueryVisualizerService implements _IQueryVisualizerService {
  final IApiRepository _apiRepository = globalLocator<IApiRepository>();
  final CountryLatLongService _countryLatLongService = globalLocator<CountryLatLongService>();
  late VisualizerModel visualizerModel;
  List<VisualizerNodeModel> updatedNodeModelList = <VisualizerNodeModel>[];

  @override
  Future<PageData<VisualizerNodeModel>> getVisualizerNodeModelList(QueryP2PReq queryP2PReq, {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Map<String, CountryLatLongModel>? countryCodeMap = await _countryLatLongService.getCountryCodeMap();

    Response<dynamic> response = await _apiRepository.fetchQueryP2P<dynamic>(ApiRequestModel<QueryP2PReq>(
      networkUri: networkUri,
      requestData: queryP2PReq,
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryP2PResp queryP2PResp = QueryP2PResp.fromJson(MockApiP2P.defaultResponse);
      List<VisualizerNodeModel> nodeModelList = <VisualizerNodeModel>[];
      for (Node node in queryP2PResp.nodeList) {
        nodeModelList.add(VisualizerNodeModel(
          peersNumber: node.peersNumber,
          ip: node.ip,
          countryLatLongModel: countryCodeMap[node.countryCode]!,
          dataCenter: node.dataCenter,
          moniker: node.moniker ?? 'Unknown',
          address: node.address,
          website: node.website,
        ));
      }

      InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);

      return PageData<VisualizerNodeModel>(
        listItems: nodeModelList,
        lastPageBool: nodeModelList.length < queryP2PReq.limit!,
        blockDateTime: interxHeaders.blockDateTime,
        cacheExpirationDateTime: interxHeaders.cacheExpirationDateTime,
      );
    } catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot parse getStatus() for URI $networkUri', logLevel: LogLevel.error);
      // throw DioParseException(response: response, error: e);
      throw Exception();
    }
  }
}
