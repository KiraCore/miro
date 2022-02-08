import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';

abstract class _ValidatorsService {
  Future<QueryValidatorsResp> getValidators(Uri networkUri, QueryValidatorsReq queryValidatorsReq);

  void ignoreMethod();
}

class QueryValidatorsService implements _ValidatorsService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<QueryValidatorsResp> getValidators(Uri networkUri, QueryValidatorsReq queryValidatorsReq) async {
    try {
      final Response<dynamic> response =
          await _apiRepository.fetchQueryValidators<dynamic>(networkUri, queryValidatorsReq);
      return QueryValidatorsResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }

  @override
  void ignoreMethod() {
    // TODO(dominik): implement ignoreMethod
  }
}
