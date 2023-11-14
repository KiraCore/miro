import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalJailCouncilor extends AProposalTypeContent {
  // TODO(Marcin): implement proposal structure when its documented

  const ProposalJailCouncilor({
    required String type,
  }) : super(type: type);

  factory ProposalJailCouncilor.fromJson(Map<String, dynamic> json) {
    return ProposalJailCouncilor(
      type: json['@type'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[];
}
