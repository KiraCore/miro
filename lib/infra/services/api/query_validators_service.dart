import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/validator.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

abstract class _IQueryValidatorsService {
  Future<List<ValidatorModel>> getValidatorsList(QueryValidatorsReq queryValidatorsReq, {Uri? optionalNetworkUri});

  Future<List<ValidatorModel>> getValidatorsByAddresses(List<String> validatorAddresses, {Uri? optionalNetworkUri});

  Future<QueryValidatorsResp> getQueryValidatorsResp(QueryValidatorsReq queryValidatorsReq, {Uri? optionalNetworkUri});
}

class QueryValidatorsService implements _IQueryValidatorsService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<List<ValidatorModel>> getValidatorsList(
    QueryValidatorsReq queryValidatorsReq, {
    Uri? optionalNetworkUri,
  }) async {
    try {
      QueryValidatorsResp queryValidatorsResp = await getQueryValidatorsResp(
        queryValidatorsReq,
        optionalNetworkUri: optionalNetworkUri,
      );
      return queryValidatorsResp.validators.map((Validator e) => ValidatorModel.fromDto(e)).toList();
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<List<ValidatorModel>> getValidatorsByAddresses(
    List<String> validatorAddresses, {
    Uri? optionalNetworkUri,
  }) async {
    QueryValidatorsResp queryValidatorsResp = await getQueryValidatorsResp(
      QueryValidatorsReq(
        all: true,
      ),
      optionalNetworkUri: optionalNetworkUri,
    );
    return queryValidatorsResp.validators
        .where((Validator e) => validatorAddresses.contains(e.address))
        .map((Validator e) => ValidatorModel.fromDto(e))
        .toList();
  }

  @override
  Future<QueryValidatorsResp> getQueryValidatorsResp(
    QueryValidatorsReq queryValidatorsReq, {
    Uri? optionalNetworkUri,
  }) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    try {
      final Response<dynamic> response =
          await _apiRepository.fetchQueryValidators<dynamic>(networkUri, queryValidatorsReq);
      return QueryValidatorsResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }
}
