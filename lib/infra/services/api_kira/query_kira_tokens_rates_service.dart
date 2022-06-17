import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/query_kira_tokens_rates_resp.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

abstract class _QueryKiraTokensRatesService {
  Future<QueryKiraTokensRatesResp> getTokenRates({Uri? optionalNetworkUri});

  void ignoreMethod();
}

class QueryKiraTokensRatesService implements _QueryKiraTokensRatesService {
  final ApiKiraRepository _apiKiraRepository = globalLocator<ApiKiraRepository>();

  @override
  Future<QueryKiraTokensRatesResp> getTokenRates({Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response = await _apiKiraRepository.fetchQueryKiraTokensRates<dynamic>(networkUri);
    return QueryKiraTokensRatesResp.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  void ignoreMethod() {
    // TODO(dominik): Hide lint warning: one_member_abstract. Remove it after create another method in this class
  }
}
