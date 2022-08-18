import 'package:dio/dio.dart';

class MockApiCosmosAuthAccounts {
  static Headers defaultHeaders = Headers.fromMap({
    'interx_block': <String>['3981144'],
    'interx_blocktime': <String>['2022-08-26T22:08:27.607151829Z'],
    'interx_chain_id': <String>['testnet-9'],
    'interx_hash': <String>['45c6689eac2fab070f7d3f0516d22d50221909be7ae7f57e68ee87b62ea7c502'],
    'interx_request_hash': <String>['0898cf33352d19f2511804788375708197d9b08187ab38651fbf73b86e2b2aa4'],
    'interx_signature': <String>['QjheNBpgTrcviTwUYUcKEKXVW/GlWAJUNO1dzRJtr+k0WSjBEUNDZkpbXzHwubQVexPCMQCN5egR1cahvJbidQ=='],
    'interx_timestamp': <String>['1661760414'],
  });

  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    'account': {
      '@type': '/cosmos.auth.v1beta1.BaseAccount',
      'account_number': '669',
      'address': 'a2lyYTE0M3E4dnhwdnV5a3Q5cHE1MGU2aG5nOXMzOHZteTg0NG44azl3eA==',
      'pub_key': 'Ch8vY29zbW9zLmNyeXB0by5zZWNwMjU2azEuUHViS2V5EiMKIQJS2rPAiepZucmSfIdFOULvZ81b4L7JIB7lETwd471MfA==',
      'sequence': '106'
    }
  };
}
