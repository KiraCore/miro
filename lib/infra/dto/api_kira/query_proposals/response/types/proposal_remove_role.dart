import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalRemoveRole extends AProposalTypeContent {
  // TODO(Marcin): implement proposal structure when its documented

  const ProposalRemoveRole({
    required String type,
  }) : super(type: type);

  factory ProposalRemoveRole.fromJson(Map<String, dynamic> json) {
    return ProposalRemoveRole(
      type: json['@type'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[];
}
