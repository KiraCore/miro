import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/verify_record.dart';

class QueryIdentityRecordVerifyRequestsByApproverResp extends Equatable {
  final List<VerifyRecord> verifyRecords;

  const QueryIdentityRecordVerifyRequestsByApproverResp({
    required this.verifyRecords,
  });

  factory QueryIdentityRecordVerifyRequestsByApproverResp.fromJson(Map<String, dynamic> json) {
    List<VerifyRecord> verifyRecords = json['verify_records'] != null
        ? (json['verify_records'] as List<dynamic>).map((dynamic e) => VerifyRecord.fromJson(e as Map<String, dynamic>)).toList()
        : List<VerifyRecord>.empty();
    return QueryIdentityRecordVerifyRequestsByApproverResp(verifyRecords: verifyRecords);
  }

  @override
  List<Object?> get props => <Object>[verifyRecords];
}
