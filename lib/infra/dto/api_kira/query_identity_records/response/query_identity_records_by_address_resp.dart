import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/record.dart';

class QueryIdentityRecordsByAddressResp extends Equatable {
  /// The identity records info
  final List<Record> records;

  const QueryIdentityRecordsByAddressResp({
    required this.records,
  });

  factory QueryIdentityRecordsByAddressResp.fromJson(Map<String, dynamic> json) {
    return QueryIdentityRecordsByAddressResp(
      records:
          (json['records'] as List<dynamic>).map((dynamic x) => Record.fromJson(x as Map<String, dynamic>)).toList(),
    );
  }

  @override
  String toString() {
    return 'QueryIdentityRecordsByAddressResp{records: $records}';
  }

  @override
  List<Object?> get props => <Object?>[records];
}
