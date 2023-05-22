import 'package:dio/dio.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/dashboard/dashboard_resp.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/repositories/api/api_repository.dart';
import 'package:miro/shared/models/dashboard/dashboard_model.dart';
import 'package:miro/shared/utils/logger/app_logger.dart';
import 'package:miro/shared/utils/logger/log_level.dart';

abstract class _IDashboardService {
  Future<DashboardModel> getDashboardModel();
}

class DashboardService implements _IDashboardService {
  final IApiRepository _apiRepository = globalLocator<IApiRepository>();

  @override
  Future<DashboardModel> getDashboardModel() async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    Response<dynamic> response = await _apiRepository.fetchDashboard<dynamic>(networkUri);

    try {
      DashboardResp dashboardResp = DashboardResp.fromJson(response.data as Map<String, dynamic>);
      return DashboardModel.fromDto(dashboardResp);
    } catch (e) {
      AppLogger().log(message: 'DashboardService: Cannot parse getDashboardModel() for URI $networkUri ${e}', logLevel: LogLevel.error);
      throw DioParseException(response: response, error: e);
    }
  }
}
