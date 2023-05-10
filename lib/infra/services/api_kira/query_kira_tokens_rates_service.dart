import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/query_kira_tokens_rates_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _IQueryKiraTokensRatesService {
  Future<QueryKiraTokensRatesResp> getTokenRates();
}

class QueryKiraTokensRatesService implements _IQueryKiraTokensRatesService {
  final IApiKiraRepository _apiKiraRepository = globalLocator<IApiKiraRepository>();

  @override
  Future<QueryKiraTokensRatesResp> getTokenRates() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensRates<dynamic>(networkUri);

    try {
      return QueryKiraTokensRatesResp.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      AppLogger().log(message: 'QueryKiraTokensRatesService: Cannot parse getTokenRates() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
