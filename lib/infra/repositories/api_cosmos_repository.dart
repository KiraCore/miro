import 'package:dio/dio.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/broadcast_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/request/query_account_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/shared/utils/api_manager.dart';

abstract class ApiCosmosRepository {
  Future<Response<T>> broadcast<T>(Uri networkUri, BroadcastReq request);

  Future<Response<T>> fetchQueryAccount<T>(Uri networkUri, QueryAccountReq request);

  Future<Response<T>> fetchQueryBalance<T>(Uri networkUri, QueryBalanceReq queryBalanceReq);
}

class RemoteApiCosmosRepository implements ApiCosmosRepository {
  final ApiManager _api = ApiManager();

  @override
  Future<Response<T>> broadcast<T>(Uri networkUri, BroadcastReq request) async {
    try {
      final Response<T> response = await _api.post<T>(
        body: request.toJson(),
        networkUri: networkUri,
        path: '/api/cosmos/txs',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryAccount<T>(Uri networkUri, QueryAccountReq request) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/cosmos/auth/accounts/${request.address}',
      );
      return response;
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
