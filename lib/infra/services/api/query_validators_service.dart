import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/dto/api/query_validators/response/validator.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _IQueryValidatorsService {
  Future<List<ValidatorModel>> getValidatorsList(QueryValidatorsReq queryValidatorsReq, {Uri? optionalNetworkUri});

  Future<List<ValidatorModel>> getValidatorsByAddresses(List<String> validatorAddresses, {Uri? optionalNetworkUri});

  Future<QueryValidatorsResp> getQueryValidatorsResp(QueryValidatorsReq queryValidatorsReq, {Uri? optionalNetworkUri});

  Future<Status?> getStatus(Uri networkUri);
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
      return queryValidatorsResp.validators.map(ValidatorModel.fromDto).toList();
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
    return queryValidatorsResp.validators.where((Validator e) => validatorAddresses.contains(e.address)).map(ValidatorModel.fromDto).toList();
  }

  @override
  Future<QueryValidatorsResp> getQueryValidatorsResp(
    QueryValidatorsReq queryValidatorsReq, {
    Uri? optionalNetworkUri,
  }) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkModuleBloc>().state.networkUri;
    try {
      final Response<dynamic> response = await _apiRepository.fetchQueryValidators<dynamic>(networkUri, queryValidatorsReq);
      return QueryValidatorsResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Status?> getStatus(Uri networkUri) async {
    try {
      final Response<dynamic> response = await _apiRepository.fetchQueryValidators<dynamic>(
        networkUri,
        QueryValidatorsReq(statusOnly: true),
      );
      return Status.fromJson(response.data as Map<String, dynamic>);
    } catch (_) {
      AppLogger().log(message: 'Cannot fetch QueryValidators status for $networkUri');
      return null;
    }
  }
}
