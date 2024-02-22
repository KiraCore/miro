import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/token_default_denom_model.dart';

class NetworkEmptyModel extends ANetworkStatusModel {
  NetworkEmptyModel({
    required ConnectionStatusType connectionStatusType,
    TokenDefaultDenomModel? tokenDefaultDenomModel,
  }) : super(
          connectionStatusType: connectionStatusType,
          tokenDefaultDenomModel: tokenDefaultDenomModel,
          uri: Uri(),
          statusColor: DesignColors.redStatus1,
        );

  @override
  NetworkEmptyModel copyWith({required ConnectionStatusType connectionStatusType}) {
    return NetworkEmptyModel(
      connectionStatusType: connectionStatusType,
      tokenDefaultDenomModel: tokenDefaultDenomModel,
    );
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, tokenDefaultDenomModel, uri.hashCode, name];
}
