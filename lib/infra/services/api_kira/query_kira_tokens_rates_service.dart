import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/query_kira_tokens_rates_resp.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _QueryKiraTokensRatesService {
  Future<QueryKiraTokensRatesResp> getTokenRates();
}

class QueryKiraTokensRatesService implements _QueryKiraTokensRatesService {
  final ApiKiraRepository _apiKiraRepository = globalLocator<ApiKiraRepository>();

  @override
  Future<QueryKiraTokensRatesResp> getTokenRates() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    try {
      final Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensRates<dynamic>(networkUri);
      return QueryKiraTokensRatesResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      AppLogger().log(message: 'QueryKiraTokensRatesService: Cannot fetch getTokenRates() for URI $networkUri ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(
        message: 'QueryKiraTokensRatesService: Cannot parse getTokenRates() for URI $networkUri ${e}',
        logLevel: LogLevel.error,
      );
      rethrow;
    }
  }
}
