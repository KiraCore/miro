import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/dashboard/dashboard_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

abstract class _DashboardService {
  Future<DashboardResp> getData({Uri? optionalNetworkUri});

  void ignoreMethod();
}

class DashboardService implements _DashboardService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<DashboardResp> getData({Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    try {
      final Response<dynamic> response = await _apiRepository.fetchDashboard<dynamic>(networkUri);
      return DashboardResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }

  @override
  void ignoreMethod() {
    // TODO(Dominik): implement ignoreMethod
  }
}
