import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';

class NetworkUnhealthyModel extends ANetworkOnlineModel {
  final InterxWarningModel interxWarningModel;

  const NetworkUnhealthyModel({
    required this.interxWarningModel,
    required ConnectionStatusType connectionStatusType,
    required DateTime lastRefreshDateTime,
    required NetworkInfoModel networkInfoModel,
    required TokenDefaultDenomModel tokenDefaultDenomModel,
    required Uri uri,
    String? name,
  }) : super(
          connectionStatusType: connectionStatusType,
          lastRefreshDateTime: lastRefreshDateTime,
          networkInfoModel: networkInfoModel,
          tokenDefaultDenomModel: tokenDefaultDenomModel,
          uri: uri,
          name: name,
          statusColor: DesignColors.yellowStatus1,
        );

  @override
  NetworkUnhealthyModel copyWith({required ConnectionStatusType connectionStatusType, DateTime? lastRefreshDateTime}) {
    return NetworkUnhealthyModel(
      interxWarningModel: interxWarningModel,
      connectionStatusType: connectionStatusType,
      lastRefreshDateTime: lastRefreshDateTime ?? this.lastRefreshDateTime!,
      networkInfoModel: networkInfoModel,
      tokenDefaultDenomModel: tokenDefaultDenomModel,
      uri: uri,
      name: name,
    );
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, interxWarningModel, connectionStatusType, networkInfoModel, tokenDefaultDenomModel, uri.hashCode, name];
}
