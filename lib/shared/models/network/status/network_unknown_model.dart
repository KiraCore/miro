import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkUnknownModel extends ANetworkStatusModel {
  const NetworkUnknownModel({
    required ConnectionStatusType connectionStatusType,
    required Uri uri,
    String? name,
  }) : super(
          connectionStatusType: connectionStatusType,
          uri: uri,
          name: name,
        );

  factory NetworkUnknownModel.fromJson(Map<String, dynamic> json) {
    return NetworkUnknownModel(
      connectionStatusType: ConnectionStatusType.disconnected,
      uri: NetworkUtils.parseUrl(json['address'] as String),
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

  NetworkUnknownModel withHttps() {
    return NetworkUnknownModel(
      connectionStatusType: connectionStatusType,
      uri: uri.replace(scheme: 'https'),
      name: name,
    );
  }

  bool isHttp() {
    return uri.scheme == 'http';
  }

  @override
  List<Object?> get props => <Object>[runtimeType, connectionStatusType, uri, name];
}
