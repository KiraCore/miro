import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';

class NetworkHealthyModel extends ANetworkOnlineModel {
  const NetworkHealthyModel({
    required NetworkInfoModel networkInfoModel,
    required ConnectionStatusType connectionStatusType,
    required Uri uri,
    String? name,
  }) : super(
          networkInfoModel: networkInfoModel,
          connectionStatusType: connectionStatusType,
          uri: uri,
          name: name,
        );

  @override
  NetworkHealthyModel copyWith({required ConnectionStatusType connectionStatusType}) {
    return NetworkHealthyModel(
      networkInfoModel: networkInfoModel,
      connectionStatusType: connectionStatusType,
      uri: uri,
      name: name,
    );
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, networkInfoModel, connectionStatusType, uri, name];
}
