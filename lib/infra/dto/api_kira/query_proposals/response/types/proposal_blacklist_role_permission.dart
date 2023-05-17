import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalBlacklistRolePermission extends AProposalTypeContent {
  final String permission;
  final String roleIdentifier;

  const ProposalBlacklistRolePermission({
    required String type,
    required this.permission,
    required this.roleIdentifier,
  }) : super(type: type);

  factory ProposalBlacklistRolePermission.fromJson(Map<String, dynamic> json) {
    return ProposalBlacklistRolePermission(
      type: json['@type'] as String,
      permission: json['permission'] as String,
      roleIdentifier: json['roleIdentifier'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[permission, roleIdentifier];
}
