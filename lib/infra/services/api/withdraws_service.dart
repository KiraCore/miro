import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/withdraws/request/withdraws_req.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

abstract class _IWithdrawsService {
  /// Throws [DioError]
  Future<WithdrawsResp?> getWithdrawsResp(WithdrawsReq withdrawsReq, {Uri? optionalNetworkUri});
}

class WithdrawsService implements _IWithdrawsService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<WithdrawsResp?> getWithdrawsResp(WithdrawsReq withdrawsReq, {Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response = await _apiRepository.fetchWithdraws<dynamic>(networkUri, withdrawsReq);
    return WithdrawsResp.fromJson(response.data as Map<String, dynamic>);
  }
}
