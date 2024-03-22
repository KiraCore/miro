import 'package:equatable/equatable.dart';

class QueryBalanceReq extends Equatable {
  final String address;
  final bool countTotal;
  final List<String>? tokens;
  final List<String>? exclude;
  final bool? derived;
  final int? limit;
  final int? offset;

  const QueryBalanceReq({
    required this.address,
    this.countTotal = true,
    this.tokens,
    this.exclude,
    this.derived,
    this.limit,
    this.offset,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'count_total': countTotal,
        'tokens': tokens?.join(','),
        'exclude': exclude?.join(','),
        'derived': derived,
        'limit': limit,
        'offset': offset,
      };

  @override
  List<Object?> get props => <Object?>[address, countTotal, tokens, exclude, derived, limit, offset];
}
