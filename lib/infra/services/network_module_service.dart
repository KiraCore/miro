import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

abstract class _INetworkModuleService {
  Future<ANetworkStatusModel> getNetworkStatusModel(NetworkUnknownModel networkUnknownModel);

  void ignoreMethod();
}

class NetworkModuleService extends _INetworkModuleService {
  final QueryInterxStatusService queryInterxStatusService = globalLocator<QueryInterxStatusService>();
  final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();

  @override
  Future<ANetworkStatusModel> getNetworkStatusModel(NetworkUnknownModel networkUnknownModel) async {
    try {
      Status? status = await queryValidatorsService.getStatus(networkUnknownModel.uri);
      QueryInterxStatusResp queryInterxStatusResp =
          await queryInterxStatusService.getQueryInterxStatusResp(networkUnknownModel.uri);
      NetworkInfoModel networkInfoModel = NetworkInfoModel.fromDto(queryInterxStatusResp, status);

      return ANetworkOnlineModel.fromNetworkInfoModel(
        uri: networkUnknownModel.uri,
        name: networkUnknownModel.name,
        networkInfoModel: networkInfoModel,
      );
    } catch (e) {
      if (networkUnknownModel.isHttp()) {
        return getNetworkStatusModel(networkUnknownModel.withHttps());
      } else {
        return NetworkOfflineModel.fromRequest(networkUnknownModel);
      }
    }
  }

  @override
  void ignoreMethod() {}
}
