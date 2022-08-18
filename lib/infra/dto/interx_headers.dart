import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class InterxHeaders extends Equatable {
  final int block;
  final String blockTime;
  final String chainId;
  final String hash;
  final String requestHash;
  final String signature;
  final int timestamp;

  const InterxHeaders({
    required this.block,
    required this.blockTime,
    required this.chainId,
    required this.hash,
    required this.requestHash,
    required this.signature,
    required this.timestamp,
  });

  factory InterxHeaders.fromHeaders(Headers headers) {
    return InterxHeaders(
      block: int.parse(headers.value('interx_block') as String),
      blockTime: headers.value('interx_blocktime') as String,
      chainId: headers.value('interx_chain_id') as String,
      hash: headers.value('interx_hash') as String,
      requestHash: headers.value('interx_request_hash') as String,
      signature: headers.value('interx_signature') as String,
      timestamp: int.parse(headers.value('interx_timestamp') as String),
    );
  }

  @override
  List<Object?> get props => <Object>[block, blockTime, chainId, hash, requestHash, signature, timestamp];
}
