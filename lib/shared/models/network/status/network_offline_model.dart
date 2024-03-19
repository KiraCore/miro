import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkOfflineModel extends ANetworkStatusModel {
  const NetworkOfflineModel({
    required ConnectionStatusType connectionStatusType,
    required DateTime lastRefreshDateTime,
    required Uri uri,
    String? name,
  }) : super(
          connectionStatusType: connectionStatusType,
          lastRefreshDateTime: lastRefreshDateTime,
          uri: uri,
          name: name,
          statusColor: DesignColors.redStatus1,
        );

  factory NetworkOfflineModel.fromNetworkStatusModel({
    required ANetworkStatusModel networkStatusModel,
    required ConnectionStatusType connectionStatusType,
    required DateTime lastRefreshDateTime,
  }) {
    return NetworkOfflineModel(
      connectionStatusType: connectionStatusType,
      lastRefreshDateTime: lastRefreshDateTime,
      uri: networkStatusModel.uri,
      name: networkStatusModel.name,
    );
  }

  @override
  NetworkOfflineModel copyWith({required ConnectionStatusType connectionStatusType, DateTime? lastRefreshDateTime, Uri? uri}) {
    return NetworkOfflineModel(
      connectionStatusType: connectionStatusType,
      lastRefreshDateTime: lastRefreshDateTime ?? DateTime.now(),
      uri: uri ?? this.uri,
      name: name,
    );
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, uri.hashCode, name];
}
