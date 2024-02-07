import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class NetworkEmptyModel extends ANetworkStatusModel {
  NetworkEmptyModel({
    required ConnectionStatusType connectionStatusType,
  }) : super(
          connectionStatusType: connectionStatusType,
          uri: Uri(),
          statusColor: DesignColors.redStatus1,
        );

  @override
  NetworkEmptyModel copyWith({required ConnectionStatusType connectionStatusType, DateTime? lastRefreshDateTime}) {
    return NetworkEmptyModel(
      connectionStatusType: connectionStatusType,
    );
  }

  @override
  List<Object?> get props => <Object?>[runtimeType, connectionStatusType, uri.hashCode, name];
}
