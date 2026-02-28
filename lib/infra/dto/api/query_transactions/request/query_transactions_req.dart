import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/list/tx_sort_type.dart';
import 'package:miro/shared/models/transactions/list/tx_status_type.dart';
import 'package:miro/shared/models/transactions/messages/interx_msg_types.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

class QueryTransactionsReq extends Equatable {
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

  const QueryTransactionsReq({
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'address': address,
        'end_date': dateEnd?.toIso8601String(),
        'start_date': dateStart?.toIso8601String(),
        'directions[]': direction?.map((TxDirectionType txDirectionType) => txDirectionType.name).join(','),
        'limit': limit,
        'offset': offset,
        'sort': sort?.name,
        'status': status?.map((TxStatusType txStatusType) => txStatusType.name).join(','),
        'type': type?.map(InterxMsgTypes.getName).join(','),
      };

  @override
  List<Object?> get props => <Object?>[address, dateEnd, dateStart, direction, limit, offset, sort, status, type];
}
