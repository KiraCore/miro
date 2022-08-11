import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/query_kira_tokens_rates_resp.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';

abstract class _QueryKiraTokensRatesService {
  Future<QueryKiraTokensRatesResp> getTokenRates();

  void ignore();
}

class QueryKiraTokensRatesService implements _QueryKiraTokensRatesService {
  final ApiKiraRepository _apiKiraRepository = globalLocator<ApiKiraRepository>();

  @override
  Future<QueryKiraTokensRatesResp> getTokenRates() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    final Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensRates<dynamic>(networkUri);
    return QueryKiraTokensRatesResp.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  // TODO(dominik): To remove
  void ignore() {}
}
