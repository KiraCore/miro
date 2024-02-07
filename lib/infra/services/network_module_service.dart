import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class _INetworkModuleService {
  Future<ANetworkStatusModel> getNetworkStatusModel(NetworkUnknownModel networkUnknownModel);
}

class NetworkModuleService implements _INetworkModuleService {
  final QueryInterxStatusService _queryInterxStatusService = globalLocator<QueryInterxStatusService>();
  final QueryKiraTokensAliasesService _queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();
  final QueryValidatorsService _queryValidatorsService = globalLocator<QueryValidatorsService>();

  @override
  Future<ANetworkStatusModel> getNetworkStatusModel(NetworkUnknownModel networkUnknownModel, {NetworkUnknownModel? previousNetworkUnknownModel}) async {
    DateTime lastRefreshDateTime = networkUnknownModel.lastRefreshDateTime ?? DateTime.now();
    try {
      NetworkInfoModel networkInfoModel = await _getNetworkInfoModel(networkUnknownModel);
      TokenDefaultDenomModel tokenDefaultDenomModel =
          await _queryKiraTokensAliasesService.getTokenDefaultDenomModel(networkUnknownModel.uri, forceRequestBool: true);
      return ANetworkOnlineModel.build(
        lastRefreshDateTime: lastRefreshDateTime,
        networkInfoModel: networkInfoModel,
        tokenDefaultDenomModel: tokenDefaultDenomModel,
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: networkUnknownModel.uri,
        name: networkUnknownModel.name,
      );
    } catch (e) {
      AppLogger().log(message: 'NetworkModuleService: Cannot fetch getNetworkStatusModel() for URI ${networkUnknownModel.uri} $e');
      if (networkUnknownModel.isHttps()) {
        return getNetworkStatusModel(
          networkUnknownModel.copyWithHttp(),
          previousNetworkUnknownModel: previousNetworkUnknownModel ?? networkUnknownModel,
        );
      } else {
        return NetworkOfflineModel.fromNetworkStatusModel(
          networkStatusModel: previousNetworkUnknownModel ?? networkUnknownModel,
          connectionStatusType: ConnectionStatusType.disconnected,
          lastRefreshDateTime: lastRefreshDateTime,
        );
      }
    }
  }

  Future<NetworkInfoModel> _getNetworkInfoModel(NetworkUnknownModel networkUnknownModel) async {
    Status? status;

    try {
      status = await _queryValidatorsService.getStatus(networkUnknownModel.uri, forceRequestBool: true);
    } catch (e) {
      AppLogger().log(message: 'NetworkModuleService: Cannot fetch getStatus() for URI ${networkUnknownModel.uri} $e');
    }

    QueryInterxStatusResp queryInterxStatusResp = await _queryInterxStatusService.getQueryInterxStatusResp(networkUnknownModel.uri, forceRequestBool: true);
    return NetworkInfoModel.fromDto(queryInterxStatusResp, status);
  }
}
