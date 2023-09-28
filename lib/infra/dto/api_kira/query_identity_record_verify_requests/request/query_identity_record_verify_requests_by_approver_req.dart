import 'package:equatable/equatable.dart';

class QueryIdentityRecordVerifyRequestsByApproverReq extends Equatable {
  final String address;
  final bool? countTotal;
  final String? key;
  final int? limit;
  final int? offset;

  const QueryIdentityRecordVerifyRequestsByApproverReq({
    required this.address,
    this.countTotal,
    this.key,
    this.limit,
    this.offset,
  });

  Map<String, dynamic> get queryParameters => <String, dynamic>{
        'count_total': countTotal,
        'key': key,
        'limit': limit,
        'offset': offset,
      };

  @override
  List<Object?> get props => <Object?>[address, countTotal, key, limit, offset];
}
