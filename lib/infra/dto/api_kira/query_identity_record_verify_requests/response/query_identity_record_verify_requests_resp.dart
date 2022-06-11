import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/pagination.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/verify_record.dart';

class QueryIdentityRecordVerifyRequestsResp extends Equatable {
  /// The identity record verify request info
  final List<VerifyRecord> verifyRecords;

  /// The pagination response information like total and next_key
  final Pagination pagination;

  const QueryIdentityRecordVerifyRequestsResp({
    required this.verifyRecords,
    required this.pagination,
  });

  factory QueryIdentityRecordVerifyRequestsResp.fromJson(Map<String, dynamic> json) {
    return QueryIdentityRecordVerifyRequestsResp(
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'] as Map<String, dynamic>)
          : const Pagination(),
      verifyRecords: json['verify_records'] != null
          ? (json['verify_records'] as List<dynamic>)
              .map((dynamic x) => VerifyRecord.fromJson(x as Map<String, dynamic>))
              .toList()
          : List<VerifyRecord>.empty(),
    );
  }

  @override
  String toString() {
    return 'QueryIdentityRecordVerifyRequestsResp{verifyRecords: $verifyRecords}';
  }

  @override
  List<Object?> get props => <Object>[
        verifyRecords,
      ];
}
