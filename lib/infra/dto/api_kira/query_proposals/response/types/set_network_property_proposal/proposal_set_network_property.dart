import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/set_network_property_proposal/network_property_value.dart';

class ProposalSetNetworkProperty extends AProposalTypeContent {
  final String networkProperty;
  final NetworkPropertyValue valueSetNetworkPropertyValue;

  const ProposalSetNetworkProperty({
    required String type,
    required this.networkProperty,
    required this.valueSetNetworkPropertyValue,
  }) : super(type: type);

  factory ProposalSetNetworkProperty.fromJson(Map<String, dynamic> json) {
    return ProposalSetNetworkProperty(
      type: json['@type'] as String,
      networkProperty: json['networkProperty'] as String,
      valueSetNetworkPropertyValue: NetworkPropertyValue.fromJson(json['value'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object> get props => <Object>[networkProperty, valueSetNetworkPropertyValue];
}
