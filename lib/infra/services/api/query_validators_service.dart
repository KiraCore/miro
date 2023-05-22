import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/dto/api/query_validators/response/validator.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryValidatorsService {
  Future<List<ValidatorModel>> getValidatorsList(QueryValidatorsReq queryValidatorsReq);

  Future<List<ValidatorModel>> getValidatorsByAddresses(List<String> validatorAddresses);

  Future<QueryValidatorsResp> getQueryValidatorsResp(QueryValidatorsReq queryValidatorsReq);

  Future<Status?> getStatus(Uri networkUri);
}

class QueryValidatorsService implements _IQueryValidatorsService {
  final IApiRepository _apiRepository = globalLocator<IApiRepository>();

  @override
  Future<List<ValidatorModel>> getValidatorsList(QueryValidatorsReq queryValidatorsReq) async {
    QueryValidatorsResp queryValidatorsResp = await getQueryValidatorsResp(queryValidatorsReq);
    return queryValidatorsResp.validators.map(ValidatorModel.fromDto).toList();
  }

  @override
  Future<List<ValidatorModel>> getValidatorsByAddresses(List<String> validatorAddresses) async {
    QueryValidatorsResp queryValidatorsResp = await getQueryValidatorsResp(const QueryValidatorsReq(all: true));
    return queryValidatorsResp.validators.where((Validator e) => validatorAddresses.contains(e.address)).map(ValidatorModel.fromDto).toList();
  }

  @override
  Future<QueryValidatorsResp> getQueryValidatorsResp(QueryValidatorsReq queryValidatorsReq) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiRepository.fetchQueryValidators<dynamic>(networkUri, queryValidatorsReq);

    return QueryValidatorsResp.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<Status> getStatus(Uri networkUri) async {
    Response<dynamic> response = await _apiRepository.fetchQueryValidators<dynamic>(networkUri, const QueryValidatorsReq(statusOnly: true));

    try {
      Status status =  Status.fromJson(response.data as Map<String, dynamic>);
      return status;
    } catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot parse getStatus() for URI $networkUri', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
