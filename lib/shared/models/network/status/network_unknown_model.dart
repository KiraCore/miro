import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

class NetworkUnknownModel extends ANetworkStatusModel {
  const NetworkUnknownModel({
    required ConnectionStatusType connectionStatusType,
    required DateTime? lastRefreshDateTime,
    required TokenDefaultDenomModel tokenDefaultDenomModel,
    required Uri uri,
    String? name,
  }) : super(
          connectionStatusType: connectionStatusType,
          lastRefreshDateTime: lastRefreshDateTime,
          tokenDefaultDenomModel: tokenDefaultDenomModel,
          uri: uri,
          name: name,
          statusColor: DesignColors.grey1,
        );

  factory NetworkUnknownModel.fromJson(Map<String, dynamic> json) {
    return NetworkUnknownModel(
      connectionStatusType: ConnectionStatusType.disconnected,
      lastRefreshDateTime: DateTime.now(),
      tokenDefaultDenomModel: TokenDefaultDenomModel.empty(),
      uri: NetworkUtils.parseUrlToInterxUri(json['address'] as String),
      name: json['name'] as String?,
    );
  }

  factory NetworkUnknownModel.fromNetworkStatusModel(ANetworkStatusModel networkStatusModel) {
    return NetworkUnknownModel(
      connectionStatusType: networkStatusModel.connectionStatusType,
      lastRefreshDateTime: DateTime.now(),
      tokenDefaultDenomModel: networkStatusModel.tokenDefaultDenomModel,
      uri: networkStatusModel.uri,
      name: networkStatusModel.name,
    );
  }

  @override
  NetworkUnknownModel copyWith({ConnectionStatusType? connectionStatusType, DateTime? lastRefreshDateTime, Uri? uri}) {
    return NetworkUnknownModel(
      connectionStatusType: connectionStatusType ?? this.connectionStatusType,
      lastRefreshDateTime: lastRefreshDateTime,
      tokenDefaultDenomModel: tokenDefaultDenomModel,
      uri: uri ?? this.uri,
      name: name,
    );
  }

  NetworkUnknownModel copyWithHttp() {
    return NetworkUnknownModel(
      connectionStatusType: connectionStatusType,
      lastRefreshDateTime: lastRefreshDateTime,
      tokenDefaultDenomModel: tokenDefaultDenomModel,
      uri: uri.replace(scheme: 'http'),
      name: name,
    );
  }

  bool isHttps() {
    return uri.isScheme('https');
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, uri.hashCode, name];
}
