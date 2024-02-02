import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';

class NetworkHealthyModel extends ANetworkOnlineModel {
  const NetworkHealthyModel({
    required ConnectionStatusType connectionStatusType,
    required TokenDefaultDenomModel? tokenDefaultDenomModel,
    required NetworkInfoModel networkInfoModel,
    required Uri uri,
    String? name,
  }) : super(
          statusColor: DesignColors.greenStatus1,
          connectionStatusType: connectionStatusType,
          tokenDefaultDenomModel: tokenDefaultDenomModel,
          networkInfoModel: networkInfoModel,
          uri: uri,
          name: name,
        );

  @override
  NetworkHealthyModel copyWith({required ConnectionStatusType connectionStatusType}) {
    return NetworkHealthyModel(
      connectionStatusType: connectionStatusType,
      tokenDefaultDenomModel: tokenDefaultDenomModel,
      networkInfoModel: networkInfoModel,
      uri: uri,
      name: name,
    );
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, tokenDefaultDenomModel, networkInfoModel, uri.hashCode, name];
}
