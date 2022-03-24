import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/withdraws/request/withdraws_req.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

abstract class _WithdrawsService {
  Future<WithdrawsResp?> getAccountWithdraws(WithdrawsReq withdrawsReq, {Uri? customNetworkUri});

  void ignoreMethod();
}

class WithdrawsService implements _WithdrawsService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<WithdrawsResp?> getAccountWithdraws(WithdrawsReq withdrawsReq, {Uri? customNetworkUri}) async {
    Uri networkUri = customNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    try {
      final Response<dynamic> response = await _apiRepository.fetchWithdraws<dynamic>(networkUri, withdrawsReq);
      return WithdrawsResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }

  @override
  void ignoreMethod() {
    // TODO(Karol): implement ignoreMethod
  }
}
