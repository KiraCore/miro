import 'package:equatable/equatable.dart';

class QueryIdentityRecordVerifyRequestsByRequesterReq extends Equatable {
  final String address;
  final bool? countTotal;
  final String? key;
  final int? limit;
  final int? offset;

  const QueryIdentityRecordVerifyRequestsByRequesterReq({
    required this.address,
    this.countTotal,
    this.key,
    this.limit,
    this.offset,
  });

  @override
  List<Object?> get props => <Object?>[address, countTotal, key, limit, offset];
}
