import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryInterxStatusService {
  Future<QueryInterxStatusResp> getQueryInterxStatusResp(Uri networkUri);
}

class QueryInterxStatusService implements _IQueryInterxStatusService {
  final IApiRepository _apiRepository = globalLocator<IApiRepository>();

  @override
  Future<QueryInterxStatusResp> getQueryInterxStatusResp(Uri networkUri, {bool forceRequestBool = false}) async {
    Response<dynamic> response = await _apiRepository.fetchQueryInterxStatus<dynamic>(ApiRequestModel<void>(
      networkUri: networkUri,
      requestData: null,
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryInterxStatusResp queryInterxStatusResp = QueryInterxStatusResp.fromJson(response.data as Map<String, dynamic>);
      return queryInterxStatusResp;
    } catch (e) {
      AppLogger().log(message: 'QueryInterxStatusService: Cannot parse getQueryInterxStatusResp() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
