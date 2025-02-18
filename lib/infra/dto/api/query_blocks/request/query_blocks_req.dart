import 'package:equatable/equatable.dart';
import 'package:miro/shared/utils/custom_date_utils.dart';

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
      // TODO(dominik): Replace camelCase with snake_case
      'dateEnd': dateEnd != null ? CustomDateUtils.parseDateToSecondsSinceEpoch(dateEnd!) : null,
      // TODO(dominik): Replace camelCase with snake_case
      'dateStart': dateStart != null ? CustomDateUtils.parseDateToSecondsSinceEpoch(dateStart!) : null,
      'limit': limit,
      'offset': offset,
      'page': page,
      'page_size': pageSize,
    };
  }

  @override
  List<Object?> get props => <Object?>[dateEnd, dateStart, limit, offset, page, pageSize];
}
