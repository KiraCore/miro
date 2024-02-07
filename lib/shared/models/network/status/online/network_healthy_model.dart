import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';

class NetworkHealthyModel extends ANetworkOnlineModel {
  const NetworkHealthyModel({
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
          statusColor: DesignColors.greenStatus1,
        );

  @override
  NetworkHealthyModel copyWith({required ConnectionStatusType connectionStatusType, DateTime? lastRefreshDateTime}) {
    return NetworkHealthyModel(
      connectionStatusType: connectionStatusType,
      lastRefreshDateTime: lastRefreshDateTime ?? this.lastRefreshDateTime!,
      networkInfoModel: networkInfoModel,
      tokenDefaultDenomModel: tokenDefaultDenomModel,
      uri: uri,
      name: name,
    );
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, networkInfoModel, tokenDefaultDenomModel, uri.hashCode, name];
}
