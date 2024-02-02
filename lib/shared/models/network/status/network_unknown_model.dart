import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/network_defaults_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkUnknownModel extends ANetworkStatusModel {
  const NetworkUnknownModel({
    required ConnectionStatusType connectionStatusType,
    required Uri uri,
    NetworkDefaultsModel? networkDefaultsModel,
    String? name,
  }) : super(
          statusColor: DesignColors.grey1,
          connectionStatusType: connectionStatusType,
          uri: uri,
          networkDefaultsModel: networkDefaultsModel,
          name: name,
        );

  factory NetworkUnknownModel.fromJson(Map<String, dynamic> json) {
    return NetworkUnknownModel(
      connectionStatusType: ConnectionStatusType.disconnected,
      uri: NetworkUtils.parseUrlToInterxUri(json['address'] as String),
      name: json['name'] as String?,
    );
  }

  factory NetworkUnknownModel.fromNetworkStatusModel(ANetworkStatusModel networkStatusModel) {
    return NetworkUnknownModel(
      connectionStatusType: networkStatusModel.connectionStatusType,
      uri: networkStatusModel.uri,
      networkDefaultsModel: networkStatusModel.networkDefaultsModel,
      name: networkStatusModel.name,
    );
  }

  @override
  NetworkUnknownModel copyWith({Uri? uri, ConnectionStatusType? connectionStatusType}) {
    return NetworkUnknownModel(
      connectionStatusType: connectionStatusType ?? this.connectionStatusType,
      uri: uri ?? this.uri,
      networkDefaultsModel: networkDefaultsModel,
      name: name,
    );
  }

  NetworkUnknownModel copyWithHttp() {
    return NetworkUnknownModel(
      connectionStatusType: connectionStatusType,
      uri: uri.replace(scheme: 'http'),
      networkDefaultsModel: networkDefaultsModel,
      name: name,
    );
  }

  bool isHttps() {
    return uri.isScheme('https');
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, uri.hashCode, networkDefaultsModel, name];
}
