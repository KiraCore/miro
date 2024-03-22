import 'package:flutter/material.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';

abstract class ANetworkOnlineModel extends ANetworkStatusModel {
  final NetworkInfoModel networkInfoModel;

  const ANetworkOnlineModel({
    required this.networkInfoModel,
    required Color statusColor,
    required ConnectionStatusType connectionStatusType,
    required DateTime lastRefreshDateTime,
    required TokenDefaultDenomModel tokenDefaultDenomModel,
    required Uri uri,
    String? name,
  }) : super(
          statusColor: statusColor,
          connectionStatusType: connectionStatusType,
          lastRefreshDateTime: lastRefreshDateTime,
          tokenDefaultDenomModel: tokenDefaultDenomModel,
          uri: uri,
          name: name,
        );

  static ANetworkOnlineModel build({
    required NetworkInfoModel networkInfoModel,
    required TokenDefaultDenomModel tokenDefaultDenomModel,
    required ConnectionStatusType connectionStatusType,
    required DateTime lastRefreshDateTime,
    required Uri uri,
    required String name,
  }) {
    InterxWarningModel interxWarningModel = InterxWarningModel.selectWarningType(networkInfoModel, tokenDefaultDenomModel);

    if (interxWarningModel.hasErrors) {
      return NetworkUnhealthyModel(
        networkInfoModel: networkInfoModel,
        tokenDefaultDenomModel: tokenDefaultDenomModel,
        connectionStatusType: connectionStatusType,
        lastRefreshDateTime: lastRefreshDateTime,
        uri: uri,
        name: name,
        interxWarningModel: interxWarningModel,
      );
    } else {
      return NetworkHealthyModel(
        networkInfoModel: networkInfoModel,
        tokenDefaultDenomModel: tokenDefaultDenomModel,
        connectionStatusType: connectionStatusType,
        lastRefreshDateTime: lastRefreshDateTime,
        uri: uri,
        name: name,
      );
    }
  }

  @override
  ANetworkOnlineModel copyWith({required ConnectionStatusType connectionStatusType, DateTime? lastRefreshDateTime});
}
