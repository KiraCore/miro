import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalRemoveBlacklistedRolePermission extends AProposalTypeContent {
  final String permission;
  final String roleSid;

  const ProposalRemoveBlacklistedRolePermission({
    required String type,
    required this.permission,
    required this.roleSid,
  }) : super(type: type);

  factory ProposalRemoveBlacklistedRolePermission.fromJson(Map<String, dynamic> json) {
    return ProposalRemoveBlacklistedRolePermission(
      type: json['@type'] as String,
      permission: json['permission'] as String,
      roleSid: json['roleSid'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[permission, roleSid];
}
