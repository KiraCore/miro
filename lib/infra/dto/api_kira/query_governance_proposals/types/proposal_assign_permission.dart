import 'package:miro/infra/dto/api_kira/query_governance_proposals/a_proposal_type_content.dart';

class ProposalAssignPermission extends AProposalTypeContent {
  final String address;
  final int permission;

  const ProposalAssignPermission({
    required String type,
    required this.address,
    required this.permission,
  }) : super(type: type);

  factory ProposalAssignPermission.fromJson(Map<String, dynamic> json) {
    return ProposalAssignPermission(
      type: json['@type'] as String,
      address: json['address'] as String,
      permission: json['permission'] as int,
    );
  }

  @override
  List<Object> get props => <Object>[address, permission];
}
