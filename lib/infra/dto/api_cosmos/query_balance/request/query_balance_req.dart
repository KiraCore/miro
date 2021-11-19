class QueryBalanceReq {
  final String address;
  final bool countTotal;
  final int? limit;
  final int? offset;

  QueryBalanceReq({
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
}