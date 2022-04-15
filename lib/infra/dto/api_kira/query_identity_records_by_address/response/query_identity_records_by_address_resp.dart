import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records_by_address/response/record.dart';

class QueryIdentityRecordsByAddressResp extends Equatable {
  final List<Record> records;

  const QueryIdentityRecordsByAddressResp({
    required this.records,
  });

  Map<String, Record> get recordsMap {
    return records.fold<Map<String, Record>>(
      <String, Record>{},
      (Map<String, Record> map, Record record) => map..addAll(<String, Record>{record.key: record}),
    );
  }

  factory QueryIdentityRecordsByAddressResp.fromJson(Map<String, dynamic> json) {
    return QueryIdentityRecordsByAddressResp(
      records:
          (json['records'] as List<dynamic>).map((dynamic x) => Record.fromJson(x as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[records];
}
