import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/request/query_delegations_req.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/response/query_delegations_resp.dart';
import 'package:miro/infra/dto/interx_headers.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryDelegationsService {
  Future<PageData<ValidatorStakingModel>> getValidatorStakingModelList(QueryDelegationsReq queryDelegationsReq);
}

class QueryDelegationsService implements _IQueryDelegationsService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();
  final QueryKiraTokensAliasesService _queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

  @override
  Future<PageData<ValidatorStakingModel>> getValidatorStakingModelList(QueryDelegationsReq queryDelegationsReq, {bool forceRequestBool = false}) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryDelegations<dynamic>(ApiRequestModel<QueryDelegationsReq>(
      networkUri: networkUri,
      requestData: queryDelegationsReq,
      forceRequestBool: forceRequestBool,
    ));

    try {
      QueryDelegationsResp queryDelegationsResp = QueryDelegationsResp.fromJson(response.data as Map<String, dynamic>);
      List<ValidatorStakingModel> stakingModelList = await _buildValidatorStakingModels(queryDelegationsResp);

      InterxHeaders interxHeaders = InterxHeaders.fromHeaders(response.headers);

      return PageData<ValidatorStakingModel>(
        listItems: stakingModelList,
        lastPageBool: stakingModelList.length < queryDelegationsReq.limit!,
        blockDateTime: interxHeaders.blockDateTime,
        cacheExpirationDateTime: interxHeaders.cacheExpirationDateTime,
      );
    } catch (e) {
      AppLogger().log(message: 'QueryDelegationsService: Cannot parse getValidatorStakingModelList() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  Future<List<ValidatorStakingModel>> _buildValidatorStakingModels(QueryDelegationsResp queryDelegationsResp) async {
    List<ValidatorStakingModel> rawStakingModelList = queryDelegationsResp.delegations.map(ValidatorStakingModel.fromDto).toList();

    List<String> involvedTokenNames = rawStakingModelList.expand((ValidatorStakingModel validatorStakingModel) => validatorStakingModel.defaultDenomNames).toList();
    List<TokenAliasModel> involvedTokenAliases = await _queryKiraTokensAliasesService.getAliasesByTokenNames(involvedTokenNames);

    List<ValidatorStakingModel> filledStakingModelList =
        rawStakingModelList.map((ValidatorStakingModel e) => e.fillTokenAliases(involvedTokenAliases)).toList();
    return filledStakingModelList;
  }
}
