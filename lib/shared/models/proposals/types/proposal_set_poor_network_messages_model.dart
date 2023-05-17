import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_set_poor_network_messages.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalSetPoorNetworkMessagesModel extends AProposalTypeContentModel {
  final List<String> messages;

  const ProposalSetPoorNetworkMessagesModel({
    required ProposalType proposalType,
    required this.messages,
  }) : super(proposalType: proposalType);

  factory ProposalSetPoorNetworkMessagesModel.fromDto(ProposalSetPoorNetworkMessages proposalSetPoorNetworkMessages) {
    return ProposalSetPoorNetworkMessagesModel(
      proposalType: ProposalType.fromString(proposalSetPoorNetworkMessages.type),
      messages: proposalSetPoorNetworkMessages.messages,
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'messages': messages,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeSetPoorNetworkMessages;
  }

  @override
  List<Object> get props => <Object>[messages];
}
