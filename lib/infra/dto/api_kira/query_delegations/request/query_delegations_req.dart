import 'package:equatable/equatable.dart';

class QueryDelegationsReq extends Equatable {
  final String? countTotal;
  final String? delegatorAddress;
  final int? limit;
  final int? offset;

  const QueryDelegationsReq({
    this.countTotal,
    this.delegatorAddress,
    this.limit,
    this.offset,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'countTotal': countTotal,
      'delegatorAddress': delegatorAddress,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  List<Object?> get props => <Object?>[countTotal, delegatorAddress, limit, offset];
}
