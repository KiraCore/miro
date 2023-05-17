import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalUnknown extends AProposalTypeContent {
  const ProposalUnknown({
    required String type,
  }) : super(type: type);

  factory ProposalUnknown.fromJson(Map<String, dynamic> json) {
    return ProposalUnknown(
      type: json['@type'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[];
}
