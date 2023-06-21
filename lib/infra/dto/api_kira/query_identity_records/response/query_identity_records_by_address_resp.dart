import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/record.dart';

class QueryIdentityRecordsByAddressResp extends Equatable {
  final List<Record> records;

  const QueryIdentityRecordsByAddressResp({
    required this.records,
  });

  factory QueryIdentityRecordsByAddressResp.fromJson(Map<String, dynamic> json) {
    return QueryIdentityRecordsByAddressResp(
      records: (json['records'] as List<dynamic>).map((dynamic x) => Record.fromJson(x as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[records];
}
