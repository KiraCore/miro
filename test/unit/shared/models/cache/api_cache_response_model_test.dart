import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/models/api_cache_response_model.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/cache/api_cache_response_model_test.dart --platform chrome --null-assertions
void main() {
  Map<String, List<String>> actualResponseHeaders = <String, List<String>>{
    'access-control-allow-credentials': <String>['true'],
    'access-control-allow-origin': <String>['*'],
    'access-control-expose-headers': <String>['*'],
    'content-length': <String>['169'],
    'content-type': <String>['application/json'],
    'date': <String>['Wed 08 Mar 2023 09:18:48 GMT'],
    'interx_block': <String>['212202'],
    'interx_blocktime': <String>['2023-03-08T09:18:33.086598145Z'],
    'interx_chain_id': <String>['localnet-1'],
    'interx_hash': <String>['5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b'],
    'interx_request_hash': <String>['e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e'],
    'interx_signature': <String>['XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=='],
    'interx_timestamp': <String>['1678267128'],
    'vary': <String>['Origin']
  };

  List<Map<String, dynamic>> actualResponseBody = <Map<String, dynamic>>[
    <String, dynamic>{
      'amount': '301228313093623',
      'decimals': 6,
      'denoms': <String>['ukex', 'mkex'],
      'icon': '',
      'name': 'Kira',
      'symbol': 'KEX'
    }
  ];

  group('Tests of ApiCacheResponseModel.isExpired getter', () {
    test('Should [return TRUE] if expiration time is before current date', () {
      // Arrange
      ApiCacheResponseModel? actualApiCacheResponseModel = ApiCacheResponseModel(
        requestId: 'GET|http://95.217.191.15:11000/api/kira/tokens/aliases',
        cacheExpirationDateTime: DateTime.parse('1999-10-24 14:22:31.000'),
        responseBody: actualResponseBody,
        headers: Headers.fromMap(<String, List<String>>{
          ...actualResponseHeaders,
          'data_source': <String>['cache']
        }),
        statusCode: 200,
      );

      // Act
      bool actualExpiredBool = actualApiCacheResponseModel.isExpired(DateTime.parse('2021-10-24 14:22:31.000'));

      // Assert
      expect(actualExpiredBool, true);
    });

    test('Should [return FALSE] if expiration time is after current date', () {
      // Arrange
      ApiCacheResponseModel? actualApiCacheResponseModel = ApiCacheResponseModel(
        requestId: 'GET|http://95.217.191.15:11000/api/kira/tokens/aliases',
        cacheExpirationDateTime: DateTime.parse('2222-10-24 14:22:31.000'),
        responseBody: actualResponseBody,
        headers: Headers.fromMap(<String, List<String>>{
          ...actualResponseHeaders,
          'data_source': <String>['cache']
        }),
        statusCode: 200,
      );

      // Act
      bool actualExpiredBool = actualApiCacheResponseModel.isExpired(DateTime.parse('2021-10-24 14:22:31.000'));

      // Assert
      expect(actualExpiredBool, false);
    });
  });

  group('Tests of ApiCacheResponseModel.timeToExpiry getter', () {
    test('Should [return POSITIVE time to expiry] (1 hour) if expiration time is after current date', () {
      // Arrange
      DateTime currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 12, 0);

      ApiCacheResponseModel? actualApiCacheResponseModel = ApiCacheResponseModel(
        requestId: 'GET|http://95.217.191.15:11000/api/kira/tokens/aliases',
        cacheExpirationDateTime: currentDate.add(const Duration(hours: 1)),
        responseBody: actualResponseBody,
        headers: Headers.fromMap(<String, List<String>>{
          ...actualResponseHeaders,
          'data_source': <String>['cache']
        }),
        statusCode: 200,
      );

      // Act
      int actualHoursToExpiry = actualApiCacheResponseModel.getTimeToExpiry(currentDate).inHours;

      // Assert
      int expectedHoursToExpiry = 1;

      expect(actualHoursToExpiry, expectedHoursToExpiry);
    });

    test('Should [return NEGATIVE time to expiry] (-1 hour) if expiration time is before current date', () {
      // Arrange
      DateTime currentDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

      ApiCacheResponseModel? actualApiCacheResponseModel = ApiCacheResponseModel(
        requestId: 'GET|http://95.217.191.15:11000/api/kira/tokens/aliases',
        cacheExpirationDateTime: currentDate.subtract(const Duration(hours: 1)),
        responseBody: actualResponseBody,
        headers: Headers.fromMap(<String, List<String>>{
          ...actualResponseHeaders,
          'data_source': <String>['cache']
        }),
        statusCode: 200,
      );

      // Act
      int actualHoursToExpiry = actualApiCacheResponseModel.getTimeToExpiry(currentDate).inHours;

      // Assert
      int expectedHoursToExpiry = -1;

      expect(actualHoursToExpiry, expectedHoursToExpiry);
    });
  });
}
