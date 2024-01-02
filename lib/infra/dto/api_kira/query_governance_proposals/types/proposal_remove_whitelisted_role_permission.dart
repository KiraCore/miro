import 'package:miro/infra/dto/api_kira/query_governance_proposals/a_proposal_type_content.dart';

class ProposalRemoveWhitelistedRolePermission extends AProposalTypeContent {
  final String permission;
  final String roleSid;

  const ProposalRemoveWhitelistedRolePermission({
    required String type,
    required this.permission,
    required this.roleSid,
  }) : super(type: type);

  factory ProposalRemoveWhitelistedRolePermission.fromJson(Map<String, dynamic> json) {
    return ProposalRemoveWhitelistedRolePermission(
      type: json['@type'] as String,
      permission: json['permission'] as String,
      roleSid: json['roleSid'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[permission, roleSid];
}
