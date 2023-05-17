import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_interx_status/validator_info.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class QueryProposalsReq extends Equatable {
  final DateTime? dateEnd;
  final DateTime? dateStart;
  final int? limit;
  final int? offset;
  final ValidatorInfo? proposerInfo;
  final String? sort;
  final String? status;
  final AProposalTypeContent? content;
  final String? voter;

  const QueryProposalsReq({
    this.dateEnd,
    this.dateStart,
    this.limit,
    this.offset,
    this.proposerInfo,
    this.sort,
    this.status,
    this.content,
    this.voter,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'dateEnd': dateEnd.toString(),
      'dateStart': dateStart.toString(),
      'limit': limit,
      'offset': offset,
      'proposer': proposerInfo?.address,
      'sort': sort,
      'status': status,
      'type': content?.type,
      'voter': voter,
    };
  }

  @override
  List<Object?> get props => <Object?>[limit, offset];
}
