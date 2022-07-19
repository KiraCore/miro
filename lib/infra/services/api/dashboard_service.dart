import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/dashboard/dashboard_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

abstract class _IDashboardService {
  /// Throws [DioError]
  Future<DashboardResp> getDashboardResp({Uri? optionalNetworkUri});
}

class DashboardService implements _IDashboardService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<DashboardResp> getDashboardResp({Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response = await _apiRepository.fetchDashboard<dynamic>(networkUri);
    return DashboardResp.fromJson(response.data as Map<String, dynamic>);
  }
}
