import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';
import 'package:miro/shared/models/proposals/types/proposal_set_network_property/network_property_model.dart';

class ProposalSetNetworkPropertyModel extends AProposalTypeContentModel {
  final String networkProperty;
  final NetworkPropertyModel networkPropertyModel;

  const ProposalSetNetworkPropertyModel({
    required ProposalType proposalType,
    required this.networkProperty,
    required this.networkPropertyModel,
  }) : super(proposalType: proposalType);

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'networkProperty': networkProperty,
      'networkPropertyModel': networkPropertyModel.toJson(),
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeSetNetworkProperty;
  }

  @override
  List<Object> get props => <Object>[networkProperty, networkPropertyModel];
}
