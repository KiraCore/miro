import 'package:miro/infra/dto/api_kira/query_governance_proposals/a_proposal_type_content.dart';

class ProposalBlacklistAccountPermission extends AProposalTypeContent {
  final String address;
  final String permission;

  const ProposalBlacklistAccountPermission({
    required String type,
    required this.address,
    required this.permission,
  }) : super(type: type);

  factory ProposalBlacklistAccountPermission.fromJson(Map<String, dynamic> json) {
    return ProposalBlacklistAccountPermission(
      type: json['@type'] as String,
      address: json['address'] as String,
      permission: json['permission'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[address, permission];
}
