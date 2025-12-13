import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/dashboard/dashboard_resp.dart';
import 'package:miro/infra/dto/api/query_blocks/request/query_blocks_req.dart';
import 'package:miro/infra/dto/api/query_blocks/response/query_blocks_resp.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/dto/api/query_proposals/response/query_proposals_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IDashboardService {
  Future<DashboardModel> getDashboardModel();
}

class DashboardService implements _IDashboardService {
  final IApiRepository _apiRepository = globalLocator<IApiRepository>();
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<DashboardModel> getDashboardModel({bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> dashboard = await _apiRepository.fetchDashboard<dynamic>(ApiRequestModel<void>(
      networkUri: networkUri,
      requestData: null,
      forceRequestBool: forceRequestBool,
    ));

    Response<dynamic> proposals = await _apiKiraRepository.fetchQueryProposals<dynamic>(ApiRequestModel<void>(
      networkUri: networkUri,
      requestData: null,
      forceRequestBool: forceRequestBool,
    ));

    Response<dynamic> blocks = await _apiRepository.fetchQueryBlocks<dynamic>(ApiRequestModel<QueryBlocksReq>(
      networkUri: networkUri,
      requestData: const QueryBlocksReq(limit: 2, offset: 0),
      forceRequestBool: forceRequestBool,
    ));

    try {
      // Parse all responses using DTOs
      DashboardResp dashboardResp = DashboardResp.fromJson(
        dashboard.data as Map<String, dynamic>? ?? <String, dynamic>{},
      );

      final Map<String, dynamic> proposalsData = proposals.data as Map<String, dynamic>? ?? <String, dynamic>{};
      QueryProposalsResp proposalsResp = QueryProposalsResp.fromJson(
        proposalsData['proposals'] as List<dynamic>? ?? <dynamic>[],
      );

      QueryBlocksResp blocksResp = QueryBlocksResp.fromJson(
        blocks.data as Map<String, dynamic>? ?? <String, dynamic>{},
      );

      QueryInterxStatusResp statusResp = await QueryInterxStatusService().getQueryInterxStatusResp(
        networkUri,
        forceRequestBool: forceRequestBool,
      );

      // Create DashboardModel from all responses - all parsing logic is in the model
      return DashboardModel.fromResponses(
        dashboardResp: dashboardResp,
        proposalsResp: proposalsResp,
        blocksResp: blocksResp,
        statusResp: statusResp,
      );
    } catch (e) {
      AppLogger().log(
          message: 'DashboardService: Cannot parse getDashboardModel() for URI $networkUri ${e}',
          logLevel: LogLevel.error);
      throw DioParseException(response: dashboard, error: e);
    }
  }
}
