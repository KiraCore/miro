import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_faucet/request/query_faucet_info_req.dart';
import 'package:miro/infra/dto/api_kira/query_faucet/response/query_faucet_info_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/models/faucet/faucet_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryKiraFaucetService {
  Future<FaucetModel> getFaucetInfo();
}

class QueryKiraFaucetService implements _IQueryKiraFaucetService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<FaucetModel> getFaucetInfo() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryFaucet<dynamic>(ApiRequestModel<QueryFaucetInfoReq>(
      networkUri: networkUri,
      requestData: const QueryFaucetInfoReq(),
    ));

    try {
      QueryFaucetInfoResp queryFaucetInfoResp = QueryFaucetInfoResp.fromJson(response.data as Map<String, dynamic>);
      return FaucetModel.fromDto(queryFaucetInfoResp);
    } catch (e) {
      AppLogger().log(message: 'QueryStakingPoolService: Cannot parse getFaucetInfo() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
