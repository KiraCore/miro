import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_account/response/pub_key.dart';

class QueryAccountResp extends Equatable {
  final String type;
  final String accountNumber;
  final String address;
  final PubKey? pubKey;
  final String? sequence;

  const QueryAccountResp({
    required this.type,
    required this.accountNumber,
    required this.address,
    this.pubKey,
    this.sequence,
  });

  factory QueryAccountResp.fromJson(Map<String, dynamic> json) {
    dynamic pubKeyValue = json['pubKey'];
    Map<String, dynamic>? pubKeyJson = pubKeyValue is Map<String, dynamic> ? pubKeyValue : null;

    return QueryAccountResp(
      type: json['@type'] as String,
      accountNumber: json['accountNumber'] as String,
      address: json['address'] as String,
      pubKey: pubKeyJson != null ? PubKey.fromJson(pubKeyJson) : null,
      sequence: json['sequence'] as String?,
    );
  }

  @override
  List<Object?> get props => <Object?>[type, accountNumber, address, pubKey, sequence];
}
