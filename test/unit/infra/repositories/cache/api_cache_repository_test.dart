import 'package:flutter_test/flutter_test.dart';
import 'package:miro/infra/entity/cache/api_cache_response_entity.dart';
import 'package:miro/infra/managers/cache/impl/memory_cache_manager.dart';
import 'package:miro/infra/repositories/cache/api_cache_repository.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/repositories/cache/api_cache_repository_test.dart --platform chrome --null-assertions
// ignore_for_file: cascade_invocations
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
    'vary': <String>['Origin'],
    'data_source': <String>['api'],
    'cache_expiration_time': <String>['2022-08-26T22:08:27.607151829Z'],
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

  // @formatter:off
  Map<String, Map<String, dynamic>> filledCache = <String, Map<String, dynamic>>{
    'api_cache': <String, String>{
      'GET|http://95.217.191.15:11000/api/kira/tokens/aliases': '{"request_id":"GET|http://95.217.191.15:11000/api/kira/tokens/aliases","cache_expiration_time":"2070-10-24 13:22:31.000Z","status_code":200,"response_body":[{"amount":"301228313093623","decimals":6,"denoms":["ukex","mkex"],"icon":"","name":"Kira","symbol":"KEX"}],"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}',
      'GET|https://testnet-rpc.kira.network/api/kira/tokens/aliases': '{"request_id":"GET|https://testnet-rpc.kira.network/api/kira/tokens/aliases","cache_expiration_time":"2023-03-08 09:19:38.719Z","status_code":200,"response_body":[{"amount":"301228313093623","decimals":6,"denoms":["ukex","mkex"],"icon":"","name":"Kira","symbol":"KEX"}],"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}',
      'GET|http://localhost/api/kira/tokens/aliases': '{"request_id":"GET|http://localhost/api/kira/tokens/aliases","cache_expiration_time":"2070-10-24 13:22:31.000Z","status_code":200,"response_body":[{"amount":"301228313093623","decimals":6,"denoms":["ukex","mkex"],"icon":"","name":"Kira","symbol":"KEX"}],"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}',
    }
  };

  Map<String, Map<String, dynamic>> emptyCache = <String, Map<String, dynamic>>{};
  // @formatter:on

  group('Tests of ApiCacheRepository.saveResponse()', () {
    test('Should [UPDATE entry] if [request EXISTS] in cache', () async {
      // Arrange
      ApiCacheResponseEntity? actualNewApiCacheResponseEntity = ApiCacheResponseEntity(
        requestId: 'GET|http://95.217.191.15:11000/api/kira/tokens/aliases',
        cacheExpirationDateTime: DateTime.parse('2070-10-24 13:22:31.000Z'),
        responseBody: const <String, dynamic>{'updated': 'responseBody'},
        headers: actualResponseHeaders,
        statusCode: 200,
      );

      MemoryCacheManager actualCacheManager = MemoryCacheManager.withMockedInitialValues(filledCache);
      ApiCacheRepository actualApiCacheRepository = ApiCacheRepository(cacheManager: actualCacheManager);

      // Act
      await actualApiCacheRepository.saveResponse(actualNewApiCacheResponseEntity);
      Map<String, dynamic> actualCache = actualCacheManager.cache;

      // Assert
      // @formatter:off
      Map<String, dynamic> expectedCache = <String, dynamic>{
        'api_cache': <String, String>{
          'GET|http://95.217.191.15:11000/api/kira/tokens/aliases': '{"request_id":"GET|http://95.217.191.15:11000/api/kira/tokens/aliases","cache_expiration_time":"2070-10-24 13:22:31.000Z","status_code":200,"response_body":{"updated":"responseBody"},"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}',
          'GET|https://testnet-rpc.kira.network/api/kira/tokens/aliases': '{"request_id":"GET|https://testnet-rpc.kira.network/api/kira/tokens/aliases","cache_expiration_time":"2023-03-08 09:19:38.719Z","status_code":200,"response_body":[{"amount":"301228313093623","decimals":6,"denoms":["ukex","mkex"],"icon":"","name":"Kira","symbol":"KEX"}],"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}',
          'GET|http://localhost/api/kira/tokens/aliases': '{"request_id":"GET|http://localhost/api/kira/tokens/aliases","cache_expiration_time":"2070-10-24 13:22:31.000Z","status_code":200,"response_body":[{"amount":"301228313093623","decimals":6,"denoms":["ukex","mkex"],"icon":"","name":"Kira","symbol":"KEX"}],"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}'
        }
      };
      // @formatter:on
      expect(actualCache, expectedCache);
    });

    test('Should [CREATE entry] if [request NOT EXISTS] in cache', () async {
      // Arrange
      ApiCacheResponseEntity? actualNewApiCacheResponseEntity = ApiCacheResponseEntity(
        requestId: 'GET|http://95.217.191.15:11000/api/kira/tokens/aliases',
        cacheExpirationDateTime: DateTime.parse('2070-10-24 13:22:31.000Z'),
        responseBody: const <String, dynamic>{'updated': 'responseBody'},
        headers: actualResponseHeaders,
        statusCode: 200,
      );

      MemoryCacheManager actualCacheManager = MemoryCacheManager.withMockedInitialValues(emptyCache);
      ApiCacheRepository actualApiCacheRepository = ApiCacheRepository(cacheManager: actualCacheManager);

      // Act
      await actualApiCacheRepository.saveResponse(actualNewApiCacheResponseEntity);
      Map<String, dynamic> actualCache = actualCacheManager.cache;

      // Assert
      // @formatter:off
      Map<String, dynamic> expectedCache = <String, dynamic>{
        'api_cache': <String, String>{
          'GET|http://95.217.191.15:11000/api/kira/tokens/aliases': '{"request_id":"GET|http://95.217.191.15:11000/api/kira/tokens/aliases","cache_expiration_time":"2070-10-24 13:22:31.000Z","status_code":200,"response_body":{"updated":"responseBody"},"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}'
        }
      };
      // @formatter:on
      expect(actualCache, expectedCache);
    });
  });

  group('Tests of ApiCacheRepository.readResponseByRequestId()', () {
    test('Should [return ApiCacheResponseEntity] if [request EXISTS] in cache', () async {
      // Arrange
      MemoryCacheManager actualCacheManager = MemoryCacheManager.withMockedInitialValues(filledCache);
      ApiCacheRepository actualApiCacheRepository = ApiCacheRepository(cacheManager: actualCacheManager);
      String actualRequestId = 'GET|http://95.217.191.15:11000/api/kira/tokens/aliases';

      // Act
      ApiCacheResponseEntity? actualApiCacheResponseEntity = await actualApiCacheRepository.readResponseByRequestId(actualRequestId);

      // Assert
      ApiCacheResponseEntity? expectedApiCacheResponseEntity = ApiCacheResponseEntity(
        requestId: 'GET|http://95.217.191.15:11000/api/kira/tokens/aliases',
        cacheExpirationDateTime: DateTime.parse('2070-10-24 13:22:31.000Z'),
        responseBody: actualResponseBody,
        headers: actualResponseHeaders,
        statusCode: 200,
      );

      expect(actualApiCacheResponseEntity, expectedApiCacheResponseEntity);
    });

    test('Should [return NULL] if [request NOT EXISTS] in cache', () async {
      // Arrange
      MemoryCacheManager actualCacheManager = MemoryCacheManager.withMockedInitialValues(filledCache);
      ApiCacheRepository actualApiCacheRepository = ApiCacheRepository(cacheManager: actualCacheManager);
      String actualRequestId = 'GET|https://kira.network/api/not_existing_endpoint';

      // Act
      ApiCacheResponseEntity? actualApiCacheResponseEntity = await actualApiCacheRepository.readResponseByRequestId(actualRequestId);

      // Assert
      expect(actualApiCacheResponseEntity, null);
    });
  });

  group('Tests of ApiCacheRepository.deleteResponseByRequestId()', () {
    test('Should [REMOVE request] if [request EXISTS] in cache', () async {
      // Arrange
      MemoryCacheManager actualCacheManager = MemoryCacheManager.withMockedInitialValues(filledCache);
      ApiCacheRepository actualApiCacheRepository = ApiCacheRepository(cacheManager: actualCacheManager);

      // Act
      await actualApiCacheRepository.deleteResponseByRequestId('GET|http://localhost/api/kira/tokens/aliases');
      Map<String, dynamic> actualCache = actualCacheManager.cache;

      // Assert
      // @formatter:off
      Map<String, dynamic> expectedCache = <String, dynamic>{
        'api_cache': <String, String>{
          'GET|http://95.217.191.15:11000/api/kira/tokens/aliases': '{"request_id":"GET|http://95.217.191.15:11000/api/kira/tokens/aliases","cache_expiration_time":"2070-10-24 13:22:31.000Z","status_code":200,"response_body":[{"amount":"301228313093623","decimals":6,"denoms":["ukex","mkex"],"icon":"","name":"Kira","symbol":"KEX"}],"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}',
          'GET|https://testnet-rpc.kira.network/api/kira/tokens/aliases': '{"request_id":"GET|https://testnet-rpc.kira.network/api/kira/tokens/aliases","cache_expiration_time":"2023-03-08 09:19:38.719Z","status_code":200,"response_body":[{"amount":"301228313093623","decimals":6,"denoms":["ukex","mkex"],"icon":"","name":"Kira","symbol":"KEX"}],"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}'
        },
      };
      // @formatter:on
      expect(actualCache, expectedCache);
    });

    test('Should [IGNORE action] if [request NOT EXISTS] in cache', () async {
      // Arrange
      MemoryCacheManager actualCacheManager = MemoryCacheManager.withMockedInitialValues(filledCache);
      ApiCacheRepository actualApiCacheRepository = ApiCacheRepository(cacheManager: actualCacheManager);

      // Act
      await actualApiCacheRepository.deleteResponseByRequestId('GET|https://kira.network/api/not_existing_endpoint');
      Map<String, dynamic> actualCache = actualCacheManager.cache;

      // Assert
      // @formatter:off
      Map<String, dynamic> expectedCache = <String, dynamic>{
        'api_cache': <String, String>{
          'GET|http://95.217.191.15:11000/api/kira/tokens/aliases': '{"request_id":"GET|http://95.217.191.15:11000/api/kira/tokens/aliases","cache_expiration_time":"2070-10-24 13:22:31.000Z","status_code":200,"response_body":[{"amount":"301228313093623","decimals":6,"denoms":["ukex","mkex"],"icon":"","name":"Kira","symbol":"KEX"}],"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}',
          'GET|https://testnet-rpc.kira.network/api/kira/tokens/aliases': '{"request_id":"GET|https://testnet-rpc.kira.network/api/kira/tokens/aliases","cache_expiration_time":"2023-03-08 09:19:38.719Z","status_code":200,"response_body":[{"amount":"301228313093623","decimals":6,"denoms":["ukex","mkex"],"icon":"","name":"Kira","symbol":"KEX"}],"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}',
          'GET|http://localhost/api/kira/tokens/aliases': '{"request_id":"GET|http://localhost/api/kira/tokens/aliases","cache_expiration_time":"2070-10-24 13:22:31.000Z","status_code":200,"response_body":[{"amount":"301228313093623","decimals":6,"denoms":["ukex","mkex"],"icon":"","name":"Kira","symbol":"KEX"}],"headers":{"access-control-allow-credentials":["true"],"access-control-allow-origin":["*"],"access-control-expose-headers":["*"],"content-length":["169"],"content-type":["application/json"],"date":["Wed 08 Mar 2023 09:18:48 GMT"],"interx_block":["212202"],"interx_blocktime":["2023-03-08T09:18:33.086598145Z"],"interx_chain_id":["localnet-1"],"interx_hash":["5ba8946a2a4ff3494ccc5e984f38a68c9ead746eec209deaa81270f92ca19d8b"],"interx_request_hash":["e20a54dacfe40ba3897af3c3d93e845bce2048ad8e491a293f2bc22f7af55f8e"],"interx_signature":["XS4v2nYuYz+XT4YHqOsrwCwgwA253Ic7A/9oAllpK7d23pqgqVf3/hY4lq9jWmYsyJ694WQbjeWShmyaxiqSbA=="],"interx_timestamp":["1678267128"],"vary":["Origin"],"data_source":["api"],"cache_expiration_time":["2022-08-26T22:08:27.607151829Z"]}}'
        }
      };
      // @formatter:on
      expect(actualCache, expectedCache);
    });
  });
}
