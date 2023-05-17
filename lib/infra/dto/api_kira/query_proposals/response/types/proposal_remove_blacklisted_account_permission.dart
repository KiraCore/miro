import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalRemoveBlacklistedAccountPermission extends AProposalTypeContent {
  final String address;
  final String permission;

  const ProposalRemoveBlacklistedAccountPermission({
    required String type,
    required this.address,
    required this.permission,
  }) : super(type: type);

  factory ProposalRemoveBlacklistedAccountPermission.fromJson(Map<String, dynamic> json) {
    return ProposalRemoveBlacklistedAccountPermission(
      type: json['@type'] as String,
      address: json['address'] as String,
      permission: json['permission'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[address, permission];
}
