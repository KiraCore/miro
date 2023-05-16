import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_execution_fee/request/query_execution_fee_request.dart';
import 'package:miro/infra/dto/api_kira/query_execution_fee/response/query_execution_fee_response.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/infra/services/api_kira/query_network_properties_service.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';

abstract class _IQueryExecutionFeeService {
  Future<TokenAmountModel> getExecutionFeeForMessage(String messageName);
}

class QueryExecutionFeeService implements _IQueryExecutionFeeService {
  final AppConfig _appConfig = globalLocator<AppConfig>();
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();
  final QueryNetworkPropertiesService _queryNetworkPropertiesService = globalLocator<QueryNetworkPropertiesService>();

  @override
  Future<TokenAmountModel> getExecutionFeeForMessage(String messageName) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;

    try {
      Response<dynamic> response = await _apiKiraRepository.fetchQueryExecutionFee<dynamic>(networkUri, QueryExecutionFeeRequest(message: messageName));

      QueryExecutionFeeResponse queryExecutionFeeResponse = QueryExecutionFeeResponse.fromJson(response.data as Map<String, dynamic>);
      TokenAmountModel feeTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.parse(queryExecutionFeeResponse.fee.executionFee),
        // tokenAliasModel - interx doesn't return denomination used in QueryExecutionFee endpoint, so we assumed that it's always represented in "ukex"
        tokenAliasModel: _appConfig.defaultFeeTokenAliasModel,
      );
      return feeTokenAmountModel;
    } catch (_) {
      AppLogger().log(message: 'Fee for ${messageName} transaction type is not set. Fetching default fee');
    }
    return _queryNetworkPropertiesService.getMinTxFee();
  }
}
