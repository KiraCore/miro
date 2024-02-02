import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/network_defaults_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkOfflineModel extends ANetworkStatusModel {
  const NetworkOfflineModel({
    required ConnectionStatusType connectionStatusType,
    required Uri uri,
    NetworkDefaultsModel? networkDefaultsModel,
    String? name,
  }) : super(
          statusColor: DesignColors.redStatus1,
          connectionStatusType: connectionStatusType,
          uri: uri,
          networkDefaultsModel: networkDefaultsModel,
          name: name,
        );

  factory NetworkOfflineModel.fromNetworkStatusModel({
    required ANetworkStatusModel networkStatusModel,
    required ConnectionStatusType connectionStatusType,
  }) {
    return NetworkOfflineModel(
      connectionStatusType: connectionStatusType,
      uri: networkStatusModel.uri,
      networkDefaultsModel: networkStatusModel.networkDefaultsModel,
      name: networkStatusModel.name,
    );
  }

  @override
  NetworkOfflineModel copyWith({required ConnectionStatusType connectionStatusType, Uri? uri}) {
    return NetworkOfflineModel(
      connectionStatusType: connectionStatusType,
      uri: uri ?? this.uri,
      networkDefaultsModel: networkDefaultsModel,
      name: name,
    );
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, uri.hashCode, networkDefaultsModel, name];
}
