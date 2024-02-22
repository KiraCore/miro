import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/token_default_denom_model.dart';

class NetworkOfflineModel extends ANetworkStatusModel {
  const NetworkOfflineModel({
    required ConnectionStatusType connectionStatusType,
    required Uri uri,
    TokenDefaultDenomModel? tokenDefaultDenomModel,
    String? name,
  }) : super(
          statusColor: DesignColors.redStatus1,
          connectionStatusType: connectionStatusType,
          uri: uri,
          tokenDefaultDenomModel: tokenDefaultDenomModel,
          name: name,
        );

  factory NetworkOfflineModel.fromNetworkStatusModel({
    required ANetworkStatusModel networkStatusModel,
    required ConnectionStatusType connectionStatusType,
  }) {
    return NetworkOfflineModel(
      connectionStatusType: connectionStatusType,
      uri: networkStatusModel.uri,
      tokenDefaultDenomModel: networkStatusModel.tokenDefaultDenomModel,
      name: networkStatusModel.name,
    );
  }

  @override
  NetworkOfflineModel copyWith({required ConnectionStatusType connectionStatusType, Uri? uri}) {
    return NetworkOfflineModel(
      connectionStatusType: connectionStatusType,
      uri: uri ?? this.uri,
      tokenDefaultDenomModel: tokenDefaultDenomModel,
      name: name,
    );
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, uri.hashCode, tokenDefaultDenomModel, name];
}
