import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_network_properties/response/query_network_properties_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/models/api_request_model.dart';
import 'package:miro/infra/repositories/api/api_kira_repository.dart';
import 'package:miro/shared/models/network/network_properties_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IQueryNetworkPropertiesService {
  Future<TokenAmountModel> getMinTxFee();
}

class QueryNetworkPropertiesService implements _IQueryNetworkPropertiesService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<TokenAmountModel> getMinTxFee() async {
    NetworkPropertiesModel networkPropertiesModel = await getNetworkProperties();
    return networkPropertiesModel.minTxFee;
  }

  Future<NetworkPropertiesModel> getNetworkProperties() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryNetworkProperties<dynamic>(ApiRequestModel<void>(
      networkUri: networkUri,
      requestData: null,
    ));

    try {
      QueryNetworkPropertiesResp queryNetworkPropertiesResp = QueryNetworkPropertiesResp.fromJson(response.data as Map<String, dynamic>);
      return NetworkPropertiesModel.fromDto(queryNetworkPropertiesResp.properties);
    } catch (e) {
      AppLogger().log(message: 'QueryNetworkPropertiesService: Cannot parse getNetworkProperties() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
