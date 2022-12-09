import 'package:flutter/material.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkUnknownModel extends ANetworkStatusModel {
  const NetworkUnknownModel({
    required ConnectionStatusType connectionStatusType,
    required Uri uri,
    String? name,
  }) : super(
          statusColor: Colors.grey,
          connectionStatusType: connectionStatusType,
          uri: uri,
          name: name,
        );

  factory NetworkUnknownModel.fromJson(Map<String, dynamic> json) {
    return NetworkUnknownModel(
      connectionStatusType: ConnectionStatusType.disconnected,
      uri: NetworkUtils.parseUrlToInterxUri(json['address'] as String),
      name: json['name'] as String,
    );
  }

  factory NetworkUnknownModel.fromNetworkStatusModel(ANetworkStatusModel networkStatusModel) {
    return NetworkUnknownModel(
      connectionStatusType: networkStatusModel.connectionStatusType,
      uri: networkStatusModel.uri,
      name: networkStatusModel.name,
    );
  }

  @override
  NetworkUnknownModel copyWith({ConnectionStatusType? connectionStatusType}) {
    return NetworkUnknownModel(
      connectionStatusType: connectionStatusType ?? this.connectionStatusType,
      uri: uri,
      name: name,
    );
  }

  NetworkUnknownModel copyWithHttp() {
    return NetworkUnknownModel(
      connectionStatusType: connectionStatusType,
      uri: uri.replace(scheme: 'http'),
      name: name,
    );
  }
  
  bool isHttps() {
    return uri.isScheme('https');
  }

  @override
  List<Object?> get props => <Object>[runtimeType, connectionStatusType, uri, name];
}
