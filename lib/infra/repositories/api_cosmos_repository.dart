import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/response/broadcast_resp.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/response/query_account_resp.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/shared/utils/api_manager.dart';

abstract class ApiCosmosRepository {
  Future<BroadcastResp> broadcast(Uri networkUri, BroadcastReq request);

  Future<QueryAccountResp> fetchQueryAccount(Uri networkUri, QueryAccountReq request);

  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq);
}

class RemoteApiCosmosRepository implements ApiCosmosRepository {
  final ApiManager _api = ApiManager();

  @override
  Future<BroadcastResp> broadcast(Uri networkUri, BroadcastReq request) async {
    try {
      final Response<Map<String, dynamic>> response = await _api.post<Map<String, dynamic>>(
        body: request.toJson(),
        networkUri: networkUri,
        path: '/api/cosmos/txs',
      );
      return BroadcastResp.fromJson(response.data!);
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<QueryAccountResp> fetchQueryAccount(Uri networkUri, QueryAccountReq request) async {
    try {
      final Response<Map<String, dynamic>> response = await _api.get<Map<String, dynamic>>(
        networkUri: networkUri,
        path: '/api/cosmos/auth/accounts/${request.address}',
      );
      return QueryAccountResp.fromJson(response.data!);
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/cosmos/bank/balances/${queryBalanceReq.address}',
        queryParameters: queryBalanceReq.toJson(),
      );
      return response;
    } on DioError {
      rethrow;
    }
  }
}
