import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalWhitelistAccountPermission extends AProposalTypeContent {
  final String address;
  final String permission;

  const ProposalWhitelistAccountPermission({
    required String type,
    required this.address,
    required this.permission,
  }) : super(type: type);

  factory ProposalWhitelistAccountPermission.fromJson(Map<String, dynamic> json) {
    return ProposalWhitelistAccountPermission(
      type: json['@type'] as String,
      address: json['address'] as String,
      permission: json['permission'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[address, permission];
}
