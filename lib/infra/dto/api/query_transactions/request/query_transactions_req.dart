import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_sort_type.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/shared/models/transactions/messages/interx_msg_types.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

class QueryTransactionsReq extends Equatable {
  /// This represents the kira account address
  final String address;

  /// This represents the ending point in timestamp or date(DD/MM/YY) format
  final String? dateEnd;

  /// This represents the starting point in timestamp or date(DD/MM/YY) format
  final String? dateStart;

  /// This represents direction of the transaction(outbound, inbound)
  final List<TxDirectionType>? direction;

  /// This represents the limit of total results to be shown. (1 ~ 100)
  final int? limit;

  /// This represents the offset of the first transaction
  final int? offset;

  /// This represents the page number of results
  final int? page;

  /// This represents the pageSize number of results. (1 ~ 100)
  final int? pageSize;

  /// This represents how the transactions should be sorted(dateASC, dateDESC)
  final TxSortType? sort;

  /// This represents the transaction status(pending, confirmed, failed)
  final List<TxStatusType>? status;

  /// This represents the transaction type
  final List<TxMsgType>? type;

  const QueryTransactionsReq({
    required this.address,
    this.dateEnd,
    this.dateStart,
    this.direction,
    this.limit,
    this.offset,
    this.page,
    this.pageSize,
    this.sort,
    this.status,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': address,
      // TODO(dominik): Replace camelCase with snake_case
      'dateEnd': dateEnd,
      // TODO(dominik): Replace camelCase with snake_case
      'dateStart': dateStart,
      'direction': direction?.map((TxDirectionType txDirectionType) => txDirectionType.name).join(','),
      'limit': limit,
      'offset': offset,
      'page': page,
      'page_size': pageSize,
      'sort': sort?.name,
      'status': status?.map((TxStatusType txStatusType) => txStatusType.name).join(','),
      'type': type?.map(InterxMsgTypes.getName).join(','),
    };
  }

  @override
  List<Object?> get props => <Object?>[address, dateEnd, dateStart, direction, limit, offset, page, pageSize, sort, status, type];
}
