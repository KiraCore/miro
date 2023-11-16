import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/dto/api/query_validators/response/validator.dart';
import 'package:miro/infra/dto/interx_headers.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryValidatorsService {
  Future<PageData<ValidatorModel>> getValidatorsList(QueryValidatorsReq queryValidatorsReq);

  Future<List<ValidatorModel>> getValidatorsByAddresses(List<String> validatorAddresses);

  Future<QueryValidatorsResp> getQueryValidatorsResp(QueryValidatorsReq queryValidatorsReq);

  Future<Status?> getStatus(Uri networkUri);
}

class QueryValidatorsService implements _IQueryValidatorsService {
  final IApiRepository _apiRepository = globalLocator<IApiRepository>();

  @override
  Future<PageData<ValidatorModel>> getValidatorsList(QueryValidatorsReq queryValidatorsReq, {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    Response<dynamic> response = await _apiRepository.fetchQueryValidators<dynamic>(ApiRequestModel<QueryValidatorsReq>(
      networkUri: networkUri,
      requestData: queryValidatorsReq,
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryValidatorsResp queryValidatorsResp = QueryValidatorsResp.fromJson(response.data as Map<String, dynamic>);
      List<ValidatorModel> validatorModelList = queryValidatorsResp.validators.map(ValidatorModel.fromDto).toList();

      InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);

      return PageData<ValidatorModel>(
        listItems: validatorModelList,
        lastPageBool: validatorModelList.length < queryValidatorsReq.limit!,
        blockDateTime: interxHeaders.blockDateTime,
        cacheExpirationDateTime: interxHeaders.cacheExpirationDateTime,
      );
    } catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot parse getValidatorsList() for URI $networkUri: $e', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  @override
  Future<List<ValidatorModel>> getValidatorsByAddresses(List<String> validatorAddresses, {bool forceRequestBool = false}) async {
    QueryValidatorsResp queryValidatorsResp = await getQueryValidatorsResp(const QueryValidatorsReq(all: true), forceRequestBool: forceRequestBool);
    return queryValidatorsResp.validators.where((Validator e) => validatorAddresses.contains(e.address)).map(ValidatorModel.fromDto).toList();
  }

  @override
  Future<QueryValidatorsResp> getQueryValidatorsResp(QueryValidatorsReq queryValidatorsReq, {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiRepository.fetchQueryValidators<dynamic>(ApiRequestModel<QueryValidatorsReq>(
      networkUri: networkUri,
      requestData: queryValidatorsReq,
      forceRequestBool: forceRequestBool,
    ));

    return QueryValidatorsResp.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<Status> getStatus(Uri networkUri, {bool forceRequestBool = false}) async {
    Response<dynamic> response = await _apiRepository.fetchQueryValidators<dynamic>(ApiRequestModel<QueryValidatorsReq>(
      networkUri: networkUri,
      requestData: const QueryValidatorsReq(statusOnly: true),
      forceRequestBool: forceRequestBool,
    ));

    try {
      Status status = Status.fromJson(response.data as Map<String, dynamic>);
      return status;
    } catch (e) {
      AppLogger().log(message: 'QueryValidatorsService: Cannot parse getStatus() for URI $networkUri', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
