import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_staking_pool/request/query_staking_pool_req.dart';
import 'package:miro/infra/dto/api_kira/query_staking_pool/response/query_staking_pool_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryStakingPoolService {
  Future<StakingPoolModel> getStakingPoolModel(WalletAddress validatorWalletAddress);
}

class QueryStakingPoolService implements _IQueryStakingPoolService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();
  final QueryKiraTokensAliasesService _queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

  @override
  Future<StakingPoolModel> getStakingPoolModel(WalletAddress validatorWalletAddress) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryStakingPool<dynamic>(ApiRequestModel<QueryStakingPoolReq>(
      networkUri: networkUri,
      requestData: QueryStakingPoolReq(validatorWalletAddress: validatorWalletAddress),
    ));

    try {
      QueryStakingPoolResp queryStakingPoolResp = QueryStakingPoolResp.fromJson(response.data as Map<String, dynamic>);
      StakingPoolModel stakingPoolModel = await _buildStakingPoolModel(queryStakingPoolResp);

      return stakingPoolModel;
    } catch (e) {
      AppLogger().log(message: 'QueryStakingPoolService: Cannot parse getStakingPoolModel() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }

  Future<StakingPoolModel> _buildStakingPoolModel(QueryStakingPoolResp queryStakingPoolResp) async {
    StakingPoolModel rawStakingPoolModel = StakingPoolModel.fromDto(queryStakingPoolResp);

    List<String> involvedTokenNames = rawStakingPoolModel.defaultDenomNames;
    List<TokenAliasModel> involvedTokenAliases = await _queryKiraTokensAliasesService.getAliasesByTokenNames(involvedTokenNames);

    StakingPoolModel filledStakingPoolModel = rawStakingPoolModel.fillTokenAliases(involvedTokenAliases);
    return filledStakingPoolModel;
  }
}
