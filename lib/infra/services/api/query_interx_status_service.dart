import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/exceptions/interx_unavailable_exception.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _IQueryInterxStatusService {
  /// Throws [InterxUnavailableException]
  Future<QueryInterxStatusResp> getQueryInterxStatusResp(Uri networkUri);
}

class QueryInterxStatusService implements _IQueryInterxStatusService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  /// Throws [InterxUnavailableException]
  @override
  Future<QueryInterxStatusResp> getQueryInterxStatusResp(Uri networkUri) async {
    try {
      final Response<dynamic> response = await _apiRepository.fetchQueryInterxStatus<dynamic>(networkUri);
      return QueryInterxStatusResp.fromJson(response.data as Map<String, dynamic>);
    } catch (_) {
      AppLogger().log(message: 'Cannot get getQueryInterxStatusResp for ${networkUri}');
      throw InterxUnavailableException();
    }
  }
}
