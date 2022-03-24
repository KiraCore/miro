import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_transaction_result/request/query_transaction_result_req.dart';
import 'package:miro/infra/dto/api/query_transaction_result/response/query_transaction_result_resp.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/providers/network_provider/network_provider.dart';

abstract class _QueryTransactionResultService {
  Future<QueryTransactionResultResp> getTransactionDetails(String txHash, {Uri? customNetworkUri});

  void ignoreMethod();
}

class QueryTransactionResultService implements _QueryTransactionResultService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<QueryTransactionResultResp> getTransactionDetails(String txHash, {Uri? customNetworkUri}) async {
    Uri networkUri = customNetworkUri ?? globalLocator<NetworkProvider>().networkUri!;
    try {
      final Response<dynamic> response = await _apiRepository.fetchQueryTransactionResult<dynamic>(
        networkUri,
        QueryTransactionResultReq(txHash: txHash),
      );
      return QueryTransactionResultResp.fromJson(response.data as Map<String, dynamic>);
    } on DioError {
      rethrow;
    }
  }

  @override
  void ignoreMethod() {
    // TODO(Dominik): implement ignoreMethod
  }
}
