import 'package:equatable/equatable.dart';

class QueryBlocksReq extends Equatable {
  /// This represents the ending point
  final DateTime? dateEnd;

  /// This represents the starting point
  final DateTime? dateStart;

  /// This represents the limit of total results to be shown
  final int? limit;

  /// This represents the offset of the first transaction
  final int? offset;

  /// This represents the page number of results
  final int? page;

  /// This represents the pageSize number of results
  final int? pageSize;

  const QueryBlocksReq({
    this.dateEnd,
    this.dateStart,
    this.limit,
    this.offset,
    this.page,
    this.pageSize,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'end_date': dateEnd?.toIso8601String(),
      'start_date': dateStart?.toIso8601String(),
      'limit': limit,
      'offset': offset,
      'page': page,
      'page_size': pageSize,
      'sort': 'desc',
    };
  }

  @override
  List<Object?> get props => <Object?>[dateEnd, dateStart, limit, offset, page, pageSize];
}
