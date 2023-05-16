import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_network_properties/response/query_network_properties_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryNetworkPropertiesService {
  Future<TokenAmountModel> getMinTxFee();
}

class QueryNetworkPropertiesService implements _IQueryNetworkPropertiesService {
  final AppConfig _appConfig = globalLocator<AppConfig>();
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<TokenAmountModel> getMinTxFee() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryNetworkProperties<dynamic>(networkUri);

    try {
      QueryNetworkPropertiesResp queryNetworkPropertiesResp = QueryNetworkPropertiesResp.fromJson(response.data as Map<String, dynamic>);
      return TokenAmountModel(
        lowestDenominationAmount: Decimal.parse(queryNetworkPropertiesResp.properties.minTxFee),
        tokenAliasModel: _appConfig.defaultFeeTokenAliasModel,
      );
    } catch (e) {
      AppLogger().log(message: 'QueryNetworkPropertiesService: Cannot parse getTxFee() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
