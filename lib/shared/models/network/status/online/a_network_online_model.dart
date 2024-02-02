import 'package:flutter/material.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/network_defaults_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';

abstract class ANetworkOnlineModel extends ANetworkStatusModel {
  final NetworkInfoModel networkInfoModel;

  const ANetworkOnlineModel({
    required this.networkInfoModel,
    required Color statusColor,
    required ConnectionStatusType connectionStatusType,
    required NetworkDefaultsModel networkDefaultsModel,
    required Uri uri,
    String? name,
  }) : super(
          statusColor: statusColor,
          connectionStatusType: connectionStatusType,
          networkDefaultsModel: networkDefaultsModel,
          uri: uri,
          name: name,
        );

  static ANetworkOnlineModel build({
    required ConnectionStatusType connectionStatusType,
    required NetworkDefaultsModel networkDefaultsModel,
    required NetworkInfoModel networkInfoModel,
    required Uri uri,
    required String name,
  }) {
    InterxWarningModel interxWarningModel = InterxWarningModel.fromNetworkInfoModel(networkInfoModel);

    if (interxWarningModel.hasErrors) {
      return NetworkUnhealthyModel(
        interxWarningModel: interxWarningModel,
        connectionStatusType: connectionStatusType,
        networkDefaultsModel: networkDefaultsModel,
        networkInfoModel: networkInfoModel,
        uri: uri,
        name: name,
      );
    } else {
      return NetworkHealthyModel(
        connectionStatusType: connectionStatusType,
        networkDefaultsModel: networkDefaultsModel,
        networkInfoModel: networkInfoModel,
        uri: uri,
        name: name,
      );
    }
  }

  @override
  ANetworkOnlineModel copyWith({required ConnectionStatusType connectionStatusType});
}
