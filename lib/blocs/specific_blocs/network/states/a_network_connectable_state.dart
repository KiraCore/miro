import 'package:miro/blocs/specific_blocs/network/a_network_state.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

abstract class ANetworkConnectableState extends ANetworkState {
  final ANetworkStatusModel networkStatusModel;

  const ANetworkConnectableState({
    required this.networkStatusModel,
  });

  @override
  List<Object> get props => <Object>[networkStatusModel.hashCode];
}
