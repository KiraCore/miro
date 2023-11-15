import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class InterxHeaders extends Equatable {
  static const String dataSourceHeaderKey = 'data_source';
  static const String cacheExpirationTimeHeaderKey = 'cache_expiration_time';

  static const String dataSourceCacheHeaderValue = 'cache';
  static const String dataSourceApiHeaderValue = 'api';

  final int block;
  final String chainId;
  final String hash;
  final String requestHash;
  final String signature;
  final int timestamp;
  final String dataSource;
  final DateTime blockDateTime;
  final DateTime? cacheExpirationDateTime;

  const InterxHeaders({
    required this.block,
    required this.chainId,
    required this.hash,
    required this.requestHash,
    required this.signature,
    required this.timestamp,
    required this.dataSource,
    required this.blockDateTime,
    this.cacheExpirationDateTime,
  });

  factory InterxHeaders.fromHeaders(Headers headers) {
    return InterxHeaders(
      block: int.parse(headers.value('interx_block') as String),
      chainId: headers.value('interx_chain_id') as String,
      hash: headers.value('interx_hash') as String,
      requestHash: headers.value('interx_request_hash') as String,
      signature: headers.value('interx_signature') as String,
      timestamp: int.parse(headers.value('interx_timestamp') as String),
      dataSource: headers.value(dataSourceHeaderKey) as String,
      blockDateTime: DateTime.parse(headers.value('interx_blocktime') as String),
      cacheExpirationDateTime: headers.value(cacheExpirationTimeHeaderKey) != null ? DateTime.parse(headers.value(cacheExpirationTimeHeaderKey) as String) : null,
    );
  }

  @override
  List<Object?> get props => <Object?>[block, chainId, hash, requestHash, signature, timestamp, dataSource, blockDateTime, cacheExpirationDateTime];
}
