import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/network_defaults_model.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkEmptyModel extends ANetworkStatusModel {
  NetworkEmptyModel({
    required ConnectionStatusType connectionStatusType,
    NetworkDefaultsModel? networkDefaultsModel,
  }) : super(
          connectionStatusType: connectionStatusType,
          networkDefaultsModel: networkDefaultsModel,
          uri: Uri(),
          statusColor: DesignColors.redStatus1,
        );

  @override
  NetworkEmptyModel copyWith({required ConnectionStatusType connectionStatusType}) {
    return NetworkEmptyModel(
      connectionStatusType: connectionStatusType,
      networkDefaultsModel: networkDefaultsModel,
    );
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, networkDefaultsModel, uri.hashCode, name];
}
