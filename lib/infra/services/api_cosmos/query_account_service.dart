import 'package:dio/dio.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/response/query_account_resp.dart';
import 'package:miro/infra/repositories/api_cosmos_repository.dart';

abstract class _QueryAccountService {
  /// Throws [DioError] and [NoNetworkException]
  Future<QueryAccountResp> fetchQueryAccount(String address, {Uri? customUri});
}

class QueryAccountService implements _QueryAccountService {
  final ApiCosmosRepository _apiCosmosRepository = globalLocator<ApiCosmosRepository>();

  @override
  Future<QueryAccountResp> fetchQueryAccount(String address, {Uri? customUri}) async {
    Uri networkUri = customUri ?? globalLocator<NetworkModuleBloc>().state.networkUri;
    try {
      final QueryAccountResp response = await _apiCosmosRepository.fetchQueryAccount(
        networkUri,
        QueryAccountReq(address: address),
      );
      return response;
    } on DioError {
      rethrow;
    }
  }
}
