import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_network_properties/response/query_network_properties_resp.dart';
import 'package:miro/infra/repositories/api_kira_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

// ignore: one_member_abstracts
abstract class _QueryNetworkPropertiesService {
  Future<QueryNetworkPropertiesResp> getNetworkProperties();
}

class QueryNetworkPropertiesService implements _QueryNetworkPropertiesService {
  final ApiKiraRepository _apiKiraRepository = globalLocator<ApiKiraRepository>();

  @override
  Future<QueryNetworkPropertiesResp> getNetworkProperties({Uri? customNetworkUri}) async {
    Uri networkUri = customNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response = await _apiKiraRepository.fetchQueryNetworkProperties<dynamic>(networkUri);
    return QueryNetworkPropertiesResp.fromJson(response.data as Map<String, dynamic>);
  }
}
