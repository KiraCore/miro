import 'package:equatable/equatable.dart';

class QueryBalanceReq extends Equatable {
  final String address;
  final bool countTotal;
  final int? limit;
  final int? offset;

  const QueryBalanceReq({
    required this.address,
    this.countTotal = true,
    this.limit,
    this.offset,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count_total': countTotal,
        'limit': limit,
        'offset': offset,
      };

  @override
  List<Object?> get props => <Object?>[address, countTotal, limit, offset];
}