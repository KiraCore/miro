import 'package:dio/dio.dart';
import 'package:miro/shared/utils/api_manager.dart';

// ignore: one_member_abstracts
abstract class IGeolocationDbRepository {
  Future<Response<T>> fetchLocationForIpAddress<T>(String ipAddress);
}

class RemoteGeolocationDbRepository implements IGeolocationDbRepository {
  final String _apiKey = '50ad4a90-fd5e-11ec-b463-1717be8c9ff1';
  final ApiManager _api = ApiManager();

  @override
  Future<Response<T>> fetchLocationForIpAddress<T>(String ipAddress) async {
    try {
      final Response<T> response = await _api.get<T>(
        networkUri: Uri.parse('https://geolocation-db.com/'),
        path: '/json/$_apiKey/$ipAddress',
        queryParameters: <String, dynamic>{},
      );
      return response;
    } on DioError {
      rethrow;
    }
  }
}
