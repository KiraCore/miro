import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_sort_type.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/shared/models/transactions/messages/interx_msg_types.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/utils/custom_date_utils.dart';

// TODO(Mykyta): combine with QueryTransactionsReq ???
class QueryBlockTransactionsReq extends Equatable {
  /// This represents the blockId you may want to fetch the transactions from
  final String blockId;

  /// This represents the kira account address
  final String? address;

  /// This represents the ending point
  final DateTime? dateEnd;

  /// This represents the starting point
  final DateTime? dateStart;

  /// This represents direction of the transaction(outbound, inbound)
  final List<TxDirectionType>? direction;

  /// This represents the limit of total results to be shown. (1 ~ 100)
  final int? limit;

  /// This represents the offset of the first transaction
  final int? offset;

  /// This represents how the transactions should be sorted(dateASC, dateDESC)
  final TxSortType? sort;

  /// This represents the transaction status(pending, confirmed, failed)
  final List<TxStatusType>? status;

  /// This represents the transaction type
  final List<TxMsgType>? type;

  const QueryBlockTransactionsReq({
    required this.blockId,
    this.address,
    this.dateEnd,
    this.dateStart,
    this.direction,
    this.limit,
    this.offset,
    this.sort,
    this.status,
    this.type,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      // 'blockId': blockId, // NOTE: already in the path
      'address': address,
      // TODO(dominik): Replace camelCase with snake_case
      'dateEnd': dateEnd != null ? CustomDateUtils.parseDateToSecondsSinceEpoch(dateEnd!) : null,
      // TODO(dominik): Replace camelCase with snake_case
      'dateStart': dateStart != null ? CustomDateUtils.parseDateToSecondsSinceEpoch(dateStart!) : null,
      'direction': direction?.map((TxDirectionType txDirectionType) => txDirectionType.name).join(','),
      'limit': limit,
      'offset': offset,
      'sort': sort?.name,
      'status': status?.map((TxStatusType txStatusType) => txStatusType.name).join(','),
      'type': type?.map(InterxMsgTypes.getName).join(','),
    };
  }

  @override
  List<Object?> get props =>
      <Object?>[blockId, address, dateEnd, dateStart, direction, limit, offset, sort, status, type];
}
