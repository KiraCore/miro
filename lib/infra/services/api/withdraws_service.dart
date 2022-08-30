import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/withdraws/request/withdraws_req.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/shared/utils/app_logger.dart';

abstract class _WithdrawsService {
  Future<WithdrawsResp?> getAccountWithdraws(WithdrawsReq withdrawsReq);
}

class WithdrawsService implements _WithdrawsService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<WithdrawsResp?> getAccountWithdraws(WithdrawsReq withdrawsReq) async {
    Uri networkUri = globalLocator<NetworkModuleBloc>().state.networkUri;
    try {
      final Response<dynamic> response = await _apiRepository.fetchWithdraws<dynamic>(networkUri, withdrawsReq);
      return WithdrawsResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError catch (e) {
      AppLogger().log(message: 'WithdrawsService: Cannot fetch getAccountWithdraws() for URI $networkUri: ${e.message}');
      rethrow;
    } catch (e) {
      AppLogger().log(
        message: 'WithdrawsService: Cannot parse getAccountWithdraws() for URI $networkUri ${e}',
        logLevel: LogLevel.error,
      );
      rethrow;
    }
  }
}
