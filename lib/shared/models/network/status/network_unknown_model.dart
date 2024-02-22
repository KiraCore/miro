import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/token_default_denom_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkUnknownModel extends ANetworkStatusModel {
  const NetworkUnknownModel({
    required ConnectionStatusType connectionStatusType,
    required Uri uri,
    TokenDefaultDenomModel? tokenDefaultDenomModel,
    String? name,
  }) : super(
          statusColor: DesignColors.grey1,
          connectionStatusType: connectionStatusType,
          uri: uri,
          tokenDefaultDenomModel: tokenDefaultDenomModel,
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
      tokenDefaultDenomModel: networkStatusModel.tokenDefaultDenomModel,
      name: networkStatusModel.name,
    );
  }

  @override
  NetworkUnknownModel copyWith({Uri? uri, ConnectionStatusType? connectionStatusType}) {
    return NetworkUnknownModel(
      connectionStatusType: connectionStatusType ?? this.connectionStatusType,
      uri: uri ?? this.uri,
      tokenDefaultDenomModel: tokenDefaultDenomModel,
      name: name,
    );
  }

  NetworkUnknownModel copyWithHttp() {
    return NetworkUnknownModel(
      connectionStatusType: connectionStatusType,
      uri: uri.replace(scheme: 'http'),
      tokenDefaultDenomModel: tokenDefaultDenomModel,
      name: name,
    );
  }

  bool isHttps() {
    return uri.isScheme('https');
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, uri.hashCode, tokenDefaultDenomModel, name];
}
