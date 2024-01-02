import 'package:miro/infra/dto/api_kira/query_governance_proposals/a_proposal_type_content.dart';
import 'package:miro/infra/dto/api_kira/query_governance_proposals/types/set_network_property_proposal/proposal_set_network_property_value.dart';

class SetNetworkProperty extends AProposalTypeContent {
  final String networkProperty;
  final SetNetworkPropertyValue valueSetNetworkPropertyValue;

  const SetNetworkProperty({
    required String type,
    required this.networkProperty,
    required this.valueSetNetworkPropertyValue,
  }) : super(type: type);

  factory SetNetworkProperty.fromJson(Map<String, dynamic> json) {
    return SetNetworkProperty(
      type: json['@type'] as String,
      networkProperty: json['networkProperty'] as String,
      valueSetNetworkPropertyValue: SetNetworkPropertyValue.fromJson(json['value'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => <Object>[networkProperty, valueSetNetworkPropertyValue];
}
