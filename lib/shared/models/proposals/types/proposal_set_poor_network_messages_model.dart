import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalSetPoorNetworkMessagesModel extends AProposalTypeContentModel {
  final List<String> messages;

  const ProposalSetPoorNetworkMessagesModel({
    required ProposalType proposalType,
    required this.messages,
  }) : super(proposalType: proposalType);

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
