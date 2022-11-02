import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/dashboard/dashboard_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _IDashboardService {
  Future<DashboardModel> getDashboardModel();
}

class DashboardService implements _IDashboardService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<DashboardModel> getDashboardModel() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    try {
      final Response<dynamic> response = await _apiRepository.fetchDashboard<dynamic>(networkUri);
      DashboardResp dashboardResp = DashboardResp.fromJson(response.data as Map<String, dynamic>);
      return DashboardModel.fromDto(dashboardResp);
    } on DioError catch (e) {
      AppLogger().log(message: 'DashboardService: Cannot fetch getDashboardModel() for URI $networkUri: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(
        message: 'DashboardService: Cannot parse getDashboardModel() for URI $networkUri ${e}',
        logLevel: LogLevel.error,
      );
      rethrow;
    }
  }
}
