import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/verify_record.dart';

class QueryIdentityRecordVerifyRequestResp extends Equatable {
  /// The identity record verify request info
  final VerifyRecord verifyRecord;

  const QueryIdentityRecordVerifyRequestResp({
    required this.verifyRecord,
  });

  factory QueryIdentityRecordVerifyRequestResp.fromJson(Map<String, dynamic> json) {
    return QueryIdentityRecordVerifyRequestResp(
      verifyRecord: VerifyRecord.fromJson(json['verify_record'] as Map<String, dynamic>),
    );
  }

  @override
  String toString() {
    return 'QueryIdentityRecordVerifyRequest{verifyRecord: $verifyRecord}';
  }

  @override
  List<Object?> get props => <Object?>[
        verifyRecord,
      ];
}
