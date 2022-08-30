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
  Future<List<ValidatorModel>> getValidatorsList(QueryValidatorsReq queryValidatorsReq);

  Future<List<ValidatorModel>> getValidatorsByAddresses(List<String> validatorAddresses);

  Future<QueryValidatorsResp> getQueryValidatorsResp(QueryValidatorsReq queryValidatorsReq);

  Future<Status?> getStatus(Uri networkUri);
}

class QueryValidatorsService implements _IQueryValidatorsService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<List<ValidatorModel>> getValidatorsList(QueryValidatorsReq queryValidatorsReq) async {
    try {
      QueryValidatorsResp queryValidatorsResp = await getQueryValidatorsResp(queryValidatorsReq);
      return queryValidatorsResp.validators.map(ValidatorModel.fromDto).toList();
    } on DioError catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot fetch getQueryValidatorsResp() ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot parse getQueryValidatorsResp() ${e}', logLevel: LogLevel.error);
      rethrow;
    }
  }

  @override
  Future<List<ValidatorModel>> getValidatorsByAddresses(List<String> validatorAddresses) async {
    try {
      QueryValidatorsResp queryValidatorsResp = await getQueryValidatorsResp(QueryValidatorsReq(all: true));
      return queryValidatorsResp.validators.where((Validator e) => validatorAddresses.contains(e.address)).map(ValidatorModel.fromDto).toList();
    } on DioError catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot fetch getValidatorsByAddresses() ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot parse getValidatorsByAddresses() ${e}', logLevel: LogLevel.error);
      rethrow;
    }
  }

  @override
  Future<QueryValidatorsResp> getQueryValidatorsResp(QueryValidatorsReq queryValidatorsReq) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    try {
      final Response<dynamic> response = await _apiRepository.fetchQueryValidators<dynamic>(networkUri, queryValidatorsReq);
      return QueryValidatorsResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot fetch getQueryValidatorsResp() for URI $networkUri: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot parse getQueryValidatorsResp() for URI $networkUri ${e}', logLevel: LogLevel.error);
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
    } on DioError catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot fetch getStatus() ${e.message} for URI $networkUri');
      return null;
    } catch (e) {
      AppLogger().log(
        message: 'QueryValidatorsService: Cannot parse getStatus() ${e} for URI $networkUri',
        logLevel: LogLevel.error,
      );
      return null;
    }
  }
}
