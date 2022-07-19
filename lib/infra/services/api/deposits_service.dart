import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/deposits/request/deposit_req.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

abstract class _IDepositsService {
  /// Throws [DioError]
  Future<DepositsResp?> getDepositsResp(DepositsReq depositsReq, {Uri? optionalNetworkUri});
}

class DepositsService implements _IDepositsService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<DepositsResp?> getDepositsResp(DepositsReq depositsReq, {Uri? optionalNetworkUri}) async {
    Uri networkUri = optionalNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    final Response<dynamic> response = await _apiRepository.fetchDeposits<dynamic>(networkUri, depositsReq);
    return DepositsResp.fromJson(response.data as Map<String, dynamic>);
  }
}
