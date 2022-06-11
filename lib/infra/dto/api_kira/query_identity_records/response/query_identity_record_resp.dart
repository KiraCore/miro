import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/record.dart';

class QueryIdentityRecordResp extends Equatable {
  /// The identity record info
  final Record record;

  const QueryIdentityRecordResp({
    required this.record,
  });

  factory QueryIdentityRecordResp.fromJson(Map<String, dynamic> json) {
    return QueryIdentityRecordResp(
      record: Record.fromJson(json['record'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'QueryIdentityRecordResp{record: $record}';
  }

  @override
  List<Object?> get props => <Object>[
        record,
      ];
}
