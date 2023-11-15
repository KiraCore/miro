import 'package:dio/dio.dart';

class MockHeaders {
  static Headers defaultHeaders = Headers.fromMap({
    'interx_block': <String>['3981144'],
    'interx_blocktime': <String>['2022-08-26T22:08:27.607151829Z'],
    'interx_chain_id': <String>['testnet-9'],
    'interx_hash': <String>['45c6689eac2fab070f7d3f0516d22d50221909be7ae7f57e68ee87b62ea7c502'],
    'interx_request_hash': <String>['0898cf33352d19f2511804788375708197d9b08187ab38651fbf73b86e2b2aa4'],
    'interx_signature': <String>['QjheNBpgTrcviTwUYUcKEKXVW/GlWAJUNO1dzRJtr+k0WSjBEUNDZkpbXzHwubQVexPCMQCN5egR1cahvJbidQ=='],
    'interx_timestamp': <String>['1661760414'],
    'data_source': <String>['api'],
    'cache_expiration_time': <String>['2022-08-26T22:08:27.607151829Z'],
  });
}
