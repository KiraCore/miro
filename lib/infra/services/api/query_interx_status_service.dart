import 'package:dio/dio.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/exceptions/interx_unavailable_exception.dart';
import 'package:miro/infra/repositories/api_repository.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/infra/interx_response_data.dart';

abstract class _QueryInterxStatusService {
  /// Throws [InterxUnavailableException]
  Future<InterxResponseData> getData(Uri networkUri);

  Future<NetworkHealthStatus> getHealth(Uri networkUri);
}

class QueryInterxStatusService extends _QueryInterxStatusService {
  final ApiRepository _apiRepository = globalLocator<ApiRepository>();

  @override
  Future<NetworkHealthStatus> getHealth(Uri networkUri) async {
    try {
      final Response<dynamic> response = await _apiRepository.fetchQueryInterxStatus<dynamic>(networkUri);
      QueryInterxStatusResp.fromJson(response.data as Map<String, dynamic>);

      return NetworkHealthStatus.online;
    } catch (_) {
      return _repeatMethodIfInvalidScheme<NetworkHealthStatus>(
        uri: networkUri,
        defaultReturnValue: NetworkHealthStatus.offline,
        methodToRepeat: (Uri newUri) async => await getHealth(newUri),
      );
    }
  }

  @override

  /// Throws [InterxUnavailableException]
  Future<InterxResponseData> getData(Uri networkUri) async {
    try {
      final Response<dynamic> response = await _apiRepository.fetchQueryInterxStatus<dynamic>(networkUri);
      return InterxResponseData(
        usedUri: networkUri,
        queryInterxStatusResp: QueryInterxStatusResp.fromJson(response.data as Map<String, dynamic>),
      );
    } catch (e) {
      return _repeatMethodIfInvalidScheme<InterxResponseData>(
        uri: networkUri,
        exceptionMessage: e.toString(),
        methodToRepeat: (Uri newUri) async => await getData(newUri),
      );
    }
  }

  /// Throws [InterxUnavailableException]
  Future<T> _repeatMethodIfInvalidScheme<T>({
    required Uri uri,
    required Future<T> Function(Uri newUri) methodToRepeat,
    T? defaultReturnValue,
    String? exceptionMessage,
  }) async {
    if (uri.isScheme('http')) {
      Uri newUri = uri.replace(scheme: 'https');
      return await methodToRepeat(newUri);
    } else {
      if (defaultReturnValue != null) {
        return defaultReturnValue;
      } else {
        throw InterxUnavailableException(
          'Interx from $uri is unavailable. Check if url is correct. Error message: $exceptionMessage',
        );
      }
    }
  }
}