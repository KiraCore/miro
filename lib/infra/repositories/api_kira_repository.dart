import 'package:dio/dio.dart';
import 'package:miro/shared/utils/api_manager.dart';

abstract class ApiKiraRepository {
  Future<Response<T>> fetchQueryKiraTokensAliases<T>(Uri networkUri);

  Future<Response<T>> fetchQueryKiraTokensRates<T>(Uri networkUri);

  Future<Response<T>> fetchQueryNetworkProperties<T>(Uri networkUri);
}

class RemoteApiKiraRepository implements ApiKiraRepository {
  final ApiManager _api = ApiManager();

  @override
  Future<Response<T>> fetchQueryKiraTokensAliases<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/kira/tokens/aliases',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryKiraTokensRates<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/kira/tokens/rates',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<Response<T>> fetchQueryNetworkProperties<T>(Uri networkUri) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: networkUri,
        path: '/api/kira/gov/network_properties',
      );
      return response;
    } on DioError {
      rethrow;
    }
  }
}
