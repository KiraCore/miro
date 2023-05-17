import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalSetPoorNetworkMessages extends AProposalTypeContent {
  final List<String> messages;

  const ProposalSetPoorNetworkMessages({
    required String type,
    required this.messages,
  }) : super(type: type);

  factory ProposalSetPoorNetworkMessages.fromJson(Map<String, dynamic> json) {
    return ProposalSetPoorNetworkMessages(
      type: json['@type'] as String,
      messages: json['messages'] as List<String>,
    );
  }

  @override
  List<Object> get props => <Object>[messages];
}
