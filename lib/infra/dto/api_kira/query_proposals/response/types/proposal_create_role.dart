import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalCreateRole extends AProposalTypeContent {
  final String roleDescription;
  final String roleSid;
  final List<String> blacklistedPermissions;
  final List<String> whitelistedPermissions;

  const ProposalCreateRole({
    required String type,
    required this.roleDescription,
    required this.roleSid,
    required this.blacklistedPermissions,
    required this.whitelistedPermissions,
  }) : super(type: type);

  factory ProposalCreateRole.fromJson(Map<String, dynamic> json) {
    return ProposalCreateRole(
      type: json['@type'] as String,
      roleDescription: json['roleDescription'] as String,
      roleSid: json['roleSid'] as String,
      blacklistedPermissions: (json['blacklistedPermissions'] as List<dynamic>).map((dynamic e) => e as String).toList(),
      whitelistedPermissions: (json['whitelistedPermissions'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  @override
  List<Object> get props {
    return <Object>[
      roleDescription,
      roleSid,
      blacklistedPermissions,
      whitelistedPermissions,
    ];
  }
}
