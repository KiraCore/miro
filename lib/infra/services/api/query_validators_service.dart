import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/validator.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/validators/validator_model.dart';

abstract class _ValidatorsService {
  Future<QueryValidatorsResp> getValidatorsResponse(QueryValidatorsReq queryValidatorsReq, {Uri? optionalNetworkUri});

  Future<List<ValidatorModel>> getValidatorsList(QueryValidatorsReq queryValidatorsReq, {Uri? optionalNetworkUri});

  Future<List<ValidatorModel>> getValidatorsByAddresses(List<String> validatorAddresses, {Uri? optionalNetworkUri});

  Future<ValidatorModel?> getValidatorByAddress(String validatorAddress, {Uri? optionalNetworkUri});
}

class QueryValidatorsService implements _ValidatorsService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<QueryValidatorsResp> getValidatorsResponse(
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

  @override
  Future<List<ValidatorModel>> getValidatorsList(
    QueryValidatorsReq queryValidatorsReq, {
    Uri? optionalNetworkUri,
  }) async {
    try {
      QueryValidatorsResp queryValidatorsResp = await getValidatorsResponse(
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
    List<ValidatorModel> validators = List<ValidatorModel>.empty(growable: true);
    for (String validatorAddress in validatorAddresses) {
      ValidatorModel? validatorModel =
          await getValidatorByAddress(validatorAddress, optionalNetworkUri: optionalNetworkUri);
      if (validatorModel != null) {
        validators.add(validatorModel);
      }
    }
    return validators;
  }

  @override
  Future<ValidatorModel?> getValidatorByAddress(
    String validatorAddress, {
    Uri? optionalNetworkUri,
  }) async {
    try {
      QueryValidatorsResp queryValidatorsResp = await getValidatorsResponse(
        QueryValidatorsReq(
          address: validatorAddress,
        ),
        optionalNetworkUri: optionalNetworkUri,
      );
      ValidatorModel validator = ValidatorModel.fromDto(queryValidatorsResp.validators.first);
      return validator;
    } catch (_) {
      return null;
    }
  }
}
