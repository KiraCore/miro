import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/record.dart';

class QueryIdentityRecordByIdResp extends Equatable {
  final Record record;

  const QueryIdentityRecordByIdResp({
    required this.record,
  });

  factory QueryIdentityRecordByIdResp.fromJson(Map<String, dynamic> json) {
    return QueryIdentityRecordByIdResp(
      record: Record.fromJson(json['record'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => <Object?>[record];
}
