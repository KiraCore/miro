import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _INetworkModuleService {
  Future<ANetworkStatusModel> getNetworkStatusModel(NetworkUnknownModel networkUnknownModel);
}

class NetworkModuleService implements _INetworkModuleService {
  final QueryInterxStatusService queryInterxStatusService = globalLocator<QueryInterxStatusService>();
  final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();

  @override
  Future<ANetworkStatusModel> getNetworkStatusModel(NetworkUnknownModel networkUnknownModel) async {
    try {
      NetworkInfoModel networkInfoModel = await _getNetworkInfoModel(networkUnknownModel);
      return ANetworkOnlineModel.build(
        networkInfoModel: networkInfoModel,
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: networkUnknownModel.uri,
        name: networkUnknownModel.name,
      );
    } catch (e) {
      if (networkUnknownModel.isHttp()) {
        return getNetworkStatusModel(networkUnknownModel.withHttps());
      } else {
        if (e is DioError) {
          AppLogger().log(message: 'NetworkModuleService: Cannot fetch getNetworkStatusModel() for URI ${networkUnknownModel.uri} ${e.message}');
        } else {
          AppLogger().log(message: 'NetworkModuleService: Cannot parse getNetworkStatusModel() for URI ${networkUnknownModel.uri} ${e}');
          rethrow;
        }
        return NetworkOfflineModel.fromNetworkStatusModel(
          networkStatusModel: networkUnknownModel,
          connectionStatusType: ConnectionStatusType.disconnected,
        );
      }
    }
  }

  Future<NetworkInfoModel> _getNetworkInfoModel(NetworkUnknownModel networkUnknownModel) async {
    try {
      Status? status = await queryValidatorsService.getStatus(networkUnknownModel.uri);
      QueryInterxStatusResp queryInterxStatusResp = await queryInterxStatusService.getQueryInterxStatusResp(networkUnknownModel.uri);
      return NetworkInfoModel.fromDto(queryInterxStatusResp, status);
    } on DioError catch (e) {
      AppLogger().log(message: 'NetworkModuleService: Cannot fetch _getNetworkInfoModel() for URI ${networkUnknownModel.uri} ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(message: 'NetworkModuleService: Cannot parse _getNetworkInfoModel() for URI ${networkUnknownModel.uri} $e');
      rethrow;
    }
  }
}
