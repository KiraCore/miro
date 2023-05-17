import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalRemoveWhitelistedAccountPermission extends AProposalTypeContent {
  final String address;
  final String permission;

  const ProposalRemoveWhitelistedAccountPermission({
    required String type,
    required this.address,
    required this.permission,
  }) : super(type: type);

  factory ProposalRemoveWhitelistedAccountPermission.fromJson(Map<String, dynamic> json) {
    return ProposalRemoveWhitelistedAccountPermission(
      type: json['@type'] as String,
      address: json['address'] as String,
      permission: json['permission'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[address, permission];
}
