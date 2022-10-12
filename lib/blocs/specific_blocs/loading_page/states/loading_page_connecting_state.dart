import 'package:miro/blocs/specific_blocs/loading_page/loading_page_state.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';

class LoadingPageConnectingState extends ALoadingPageState {
  const LoadingPageConnectingState({
    ANetworkStatusModel? networkStatusModel,
  }) : super(networkStatusModel: networkStatusModel);
}
