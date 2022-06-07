import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';

abstract class ANetworkOnlineModel extends ANetworkStatusModel {
  final NetworkInfoModel networkInfoModel;

  const ANetworkOnlineModel({
    required this.networkInfoModel,
    required ConnectionStatusType connectionStatusType,
    required Uri uri,
    String? name,
  }) : super(
          connectionStatusType: connectionStatusType,
          uri: uri,
          name: name,
        );

  static ANetworkOnlineModel build({
    required NetworkInfoModel networkInfoModel,
    required ConnectionStatusType connectionStatusType,
    required Uri uri,
    required String name,
  }) {
    InterxWarningModel interxWarningModel = InterxWarningModel.fromNetworkInfoModel(networkInfoModel);

    if (interxWarningModel.hasErrors) {
      return NetworkUnhealthyModel(
        interxWarningModel: interxWarningModel,
        networkInfoModel: networkInfoModel,
        connectionStatusType: connectionStatusType,
        uri: uri,
        name: name,
      );
    } else {
      return NetworkHealthyModel(
        networkInfoModel: networkInfoModel,
        connectionStatusType: connectionStatusType,
        uri: uri,
        name: name,
      );
    }
  }

  @override
  ANetworkOnlineModel copyWith({required ConnectionStatusType connectionStatusType});
}
