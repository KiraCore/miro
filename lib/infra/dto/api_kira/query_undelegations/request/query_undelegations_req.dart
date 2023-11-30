import 'package:equatable/equatable.dart';

class QueryUndelegationsReq extends Equatable {
  final String? countTotal;
  final String? undelegatorAddress;
  final int? limit;
  final int? offset;

  const QueryUndelegationsReq({
    this.countTotal,
    this.undelegatorAddress,
    this.limit,
    this.offset,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'countTotal': countTotal,
      'undelegatorAddress': undelegatorAddress,
      'limit': limit,
      'offset': offset,
    };
  }

  @override
  List<Object?> get props => <Object?>[countTotal, undelegatorAddress, limit, offset];
}
