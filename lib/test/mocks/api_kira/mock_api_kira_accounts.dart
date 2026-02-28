import 'package:dio/dio.dart';

class MockApiKiraAccounts {
  static Headers defaultHeaders = Headers.fromMap({
    'interx_block': <String>['3981144'],
    'interx_blocktime': <String>['2022-08-26T22:08:27.607151829Z'],
    'interx_chain_id': <String>['testnet-9'],
    'interx_hash': <String>['45c6689eac2fab070f7d3f0516d22d50221909be7ae7f57e68ee87b62ea7c502'],
    'interx_request_hash': <String>['0898cf33352d19f2511804788375708197d9b08187ab38651fbf73b86e2b2aa4'],
    'interx_signature': <String>['QjheNBpgTrcviTwUYUcKEKXVW/GlWAJUNO1dzRJtr+k0WSjBEUNDZkpbXzHwubQVexPCMQCN5egR1cahvJbidQ=='],
    'interx_timestamp': <String>['1661760414'],
  });

  // Updated to match QueryAccountResp.fromJson expected structure (camelCase keys, no wrapper)
  static Map<String, dynamic> defaultResponse = <String, dynamic>{
    '@type': '/cosmos.auth.v1beta1.BaseAccount',
    'accountNumber': '669',
    'address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
    'pubKey': {
      'typeUrl': '/cosmos.crypto.secp256k1.PubKey',
      'value': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
    },
    'sequence': '106'
  };
}
