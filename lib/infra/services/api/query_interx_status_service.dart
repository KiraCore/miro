import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _IQueryInterxStatusService {
  Future<QueryInterxStatusResp> getQueryInterxStatusResp(Uri networkUri);
}

class QueryInterxStatusService implements _IQueryInterxStatusService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();
  
  @override
  Future<QueryInterxStatusResp> getQueryInterxStatusResp(Uri networkUri) async {
    try {
      final Response<dynamic> response = await _apiRepository.fetchQueryInterxStatus<dynamic>(networkUri);
      QueryInterxStatusResp queryInterxStatusResp = QueryInterxStatusResp.fromJson(response.data as Map<String, dynamic>);
      return queryInterxStatusResp;
    } on DioError catch (e) {
      AppLogger().log(message: 'QueryInterxStatusService: Cannot fetch getQueryInterxStatusResp() for URI $networkUri: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(
        message: 'QueryInterxStatusService: Cannot parse getQueryInterxStatusResp() for URI $networkUri ${e}',
        logLevel: LogLevel.error,
      );
      rethrow;
    }
  }
}
