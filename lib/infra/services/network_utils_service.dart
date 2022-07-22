import 'package:miro/config/locator.dart';
import 'package:miro/config/supported_interx.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/models/network/status/online/interx_error.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';

abstract class _INetworkUtilsService {
  Future<ANetworkStatusModel> getNetworkStatusModel(NetworkUnknownModel networkUnknownModel);

  void ignoreMethod();
}

class NetworkUtilsService extends _INetworkUtilsService {
  final QueryInterxStatusService queryInterxStatusService = globalLocator<QueryInterxStatusService>();
  final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();

  @override
  Future<ANetworkStatusModel> getNetworkStatusModel(NetworkUnknownModel networkUnknownModel) async {
    try {
      Status? status = await queryValidatorsService.getStatus(networkUnknownModel.uri);
      QueryInterxStatusResp queryInterxStatusResp =
          await queryInterxStatusService.getQueryInterxStatusResp(networkUnknownModel.uri);

      ANetworkStatusModel networkStatusModel = _buildNetworkOnlineModel(
        networkUnknownModel: networkUnknownModel,
        networkInfoModel: NetworkInfoModel.fromDto(queryInterxStatusResp, status),
      );

      return networkStatusModel;
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

  ANetworkOnlineModel _buildNetworkOnlineModel({
    required NetworkUnknownModel networkUnknownModel,
    required NetworkInfoModel networkInfoModel,
  }) {
    List<InterxError> interxErrors = _getInterxErrors(networkInfoModel);

    if (interxErrors.isEmpty) {
      return NetworkHealthyModel(
        uri: networkUnknownModel.uri,
        name: networkUnknownModel.name,
        networkInfoModel: networkInfoModel,
      );
    } else {
      return NetworkUnhealthyModel(
        uri: networkUnknownModel.uri,
        name: networkUnknownModel.name,
        networkInfoModel: networkInfoModel,
        interxErrors: interxErrors,
      );
    }
  }

  List<InterxError> _getInterxErrors(NetworkInfoModel networkInfoModel) {
    bool blockTimeOutdated = _isBlockTimeOutdated(latestBlockTime: networkInfoModel.latestBlockTime);
    bool versionOutdated = !SupportedInterx.isSupported(networkInfoModel.chainId);

    return <InterxError>[
      if (versionOutdated) InterxError.versionOutdated,
      if (blockTimeOutdated) InterxError.blockTimeOutdated
    ];
  }

  bool _isBlockTimeOutdated({required DateTime latestBlockTime}) {
    DateTime now = DateTime.now().toUtc();
    return now.difference(latestBlockTime.toUtc()).inMinutes > 5;
  }
}
