import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/dashboard/dashboard_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _DashboardService {
  Future<DashboardResp> getData();
}

class DashboardService implements _DashboardService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<DashboardResp> getData() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    try {
      final Response<dynamic> response = await _apiRepository.fetchDashboard<dynamic>(networkUri);
      return DashboardResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      AppLogger().log(message: 'DashboardService: Cannot fetch getData() for URI $networkUri: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(
        message: 'DashboardService: Cannot parse getData() for URI $networkUri ${e}',
        logLevel: LogLevel.error,
      );
      rethrow;
    }
  }
}
