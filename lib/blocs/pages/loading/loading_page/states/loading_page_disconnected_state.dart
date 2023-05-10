import 'package:miro/blocs/pages/loading/loading_page/loading_page_state.dart';
import 'package:miro/shared/models/network/connection/connection_error_type.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class LoadingPageDisconnectedState extends ALoadingPageState {
  final ConnectionErrorType connectionErrorType;

  LoadingPageDisconnectedState({
    ConnectionErrorType? connectionErrorType,
    ANetworkStatusModel? networkStatusModel,
  })  : connectionErrorType = connectionErrorType ?? ConnectionErrorType.canceledByUser,
        super(networkStatusModel: networkStatusModel?.copyWith(connectionStatusType: ConnectionStatusType.disconnected));

  @override
  List<Object?> get props => <Object?>[networkStatusModel, connectionErrorType];
}
