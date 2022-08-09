import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkOfflineModel extends ANetworkStatusModel {
  const NetworkOfflineModel({
    required ConnectionStatusType connectionStatusType,
    required Uri uri,
    String? name,
  }) : super(
          statusColor: DesignColors.red_100,
          connectionStatusType: connectionStatusType,
          uri: uri,
          name: name,
        );

  factory NetworkOfflineModel.fromNetworkStatusModel({
    required ANetworkStatusModel networkStatusModel,
    required ConnectionStatusType connectionStatusType,
  }) {
    return NetworkOfflineModel(
      connectionStatusType: connectionStatusType,
      uri: networkStatusModel.uri,
      name: networkStatusModel.name,
    );
  }

  @override
  NetworkOfflineModel copyWith({required ConnectionStatusType connectionStatusType}) {
    return NetworkOfflineModel(
      connectionStatusType: connectionStatusType,
      uri: uri,
      name: name,
    );
  }

  @override
  List<Object?> get props => <Object>[runtimeType, connectionStatusType, uri, name];
}
