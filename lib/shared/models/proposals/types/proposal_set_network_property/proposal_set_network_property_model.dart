import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/set_network_property_proposal/proposal_set_network_property.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';
import 'package:miro/shared/models/proposals/types/proposal_set_network_property/network_property_value_model.dart';

class ProposalSetNetworkPropertyModel extends AProposalTypeContentModel {
  final String networkProperty;
  final NetworkPropertyValueModel valueModel;

  const ProposalSetNetworkPropertyModel({
    required ProposalType proposalType,
    required this.networkProperty,
    required this.valueModel,
  }) : super(proposalType: proposalType);

  factory ProposalSetNetworkPropertyModel.fromDto(ProposalSetNetworkProperty proposalSetNetworkProperty) {
    return ProposalSetNetworkPropertyModel(
      proposalType: ProposalType.fromString(proposalSetNetworkProperty.type),
      networkProperty: proposalSetNetworkProperty.networkProperty,
      valueModel: NetworkPropertyValueModel(
        strValue: proposalSetNetworkProperty.valueSetNetworkPropertyValue.strValue,
        value: proposalSetNetworkProperty.valueSetNetworkPropertyValue.value,
      ),
    );
  }

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'networkProperty': networkProperty,
      'networkPropertyModel': <String, dynamic>{
        'strValue': valueModel.strValue,
        'value': valueModel.value,
      },
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeSetNetworkProperty;
  }

  @override
  List<Object> get props => <Object>[networkProperty, valueModel];
}
