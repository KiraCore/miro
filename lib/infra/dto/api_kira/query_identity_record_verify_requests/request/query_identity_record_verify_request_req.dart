import 'package:equatable/equatable.dart';

class QueryIdentityRecordVerifyRequestReq extends Equatable {
  /// This is the identity record verify request id
  final String requestId;

  const QueryIdentityRecordVerifyRequestReq({
    required this.requestId,
  });

  @override
  String toString() {
    return 'QueryIdentityRecordVerifyRequestReq{requestId: $requestId}';
  }

  @override
  List<Object?> get props => <Object>[requestId];
}
