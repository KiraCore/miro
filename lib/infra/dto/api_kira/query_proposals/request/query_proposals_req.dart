import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_interx_status/validator_info.dart';
import 'package:miro/shared/utils/custom_date_utils.dart';

class QueryProposalsReq extends Equatable {
  final DateTime? dateEnd;
  final DateTime? dateStart;
  final int? limit;
  final int? offset;
  final ValidatorInfo? proposerInfo;
  final String? sort;
  final List<String>? status;
  final String? type;
  final String? voter;

  const QueryProposalsReq({
    this.dateEnd,
    this.dateStart,
    this.limit,
    this.offset,
    this.proposerInfo,
    this.sort,
    this.status,
    this.type,
    this.voter,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'date_end': dateEnd!= null ? CustomDateUtils.parseDateToSecondsSinceEpoch(dateEnd!) : null,
      'date_start': dateStart!= null ? CustomDateUtils.parseDateToSecondsSinceEpoch(dateStart!) : null,
      'limit': limit,
      'offset': offset,
      'proposer': proposerInfo?.address,
      'sort': sort,
      'status': status?.join(','),
      'type': type,
      'voter': voter,
    };
  }

  @override
  List<Object?> get props => <Object?>[dateEnd, dateStart, limit, offset, proposerInfo, sort, status, type, voter];
}
