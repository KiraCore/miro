import 'package:miro/infra/dto/api_kira/query_governance_proposals/a_proposal_type_content.dart';

class ProposalAssignRoleToAccount extends AProposalTypeContent {
  final String address;
  final String roleIdentifier;

  const ProposalAssignRoleToAccount({
    required String type,
    required this.address,
    required this.roleIdentifier,
  }) : super(type: type);

  factory ProposalAssignRoleToAccount.fromJson(Map<String, dynamic> json) {
    return ProposalAssignRoleToAccount(
      type: json['@type'] as String,
      address: json['address'] as String,
      roleIdentifier: json['roleIdentifier'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[address, roleIdentifier];
}
