import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_network_properties/response/properties.dart';

class QueryNetworkPropertiesResp extends Equatable {
  final Properties properties;

  const QueryNetworkPropertiesResp({
    required this.properties,
  });

  factory QueryNetworkPropertiesResp.fromJson(Map<String, dynamic> json) {
    return QueryNetworkPropertiesResp(
      properties: Properties.fromJson(json['properties'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => <Object>[properties.hashCode];
}
