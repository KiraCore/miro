import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/infra/interx_response_data.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/network_utils.dart';

part 'network_connector_state.dart';

class NetworkConnectorCubit extends Cubit<NetworkConnectorState> {
  final QueryInterxStatusService queryInterxStatusService;
  final NetworkProvider networkProvider = globalLocator<NetworkProvider>();

  NetworkConnectorCubit({required this.queryInterxStatusService}) : super(NetworkConnectorInitialState()) {
    connectFromUrl();
  }

  Future<void> connectFromUrl({String? url}) async {
    final Uri baseUri = url != null ? NetworkUtils.parseUrl(url) : Uri.base;
    final String? networkSrc = baseUri.queryParameters['rpc'];

    if (networkSrc != null) {
      NetworkModel urlNetworkModel = NetworkModel(
        url: networkSrc,
        name: networkSrc,
        status: NetworkHealthStatus.waiting,
      );

      networkProvider.changeCurrentNetwork(urlNetworkModel);
      emit(NetworkConnectorConnectedState(currentNetwork: urlNetworkModel));
      await connect(urlNetworkModel);
    }
  }

  Future<bool> checkConnection(String url) async {
    Uri networkUri = NetworkUtils.parseUrl(url);
    NetworkHealthStatus networkHealthStatus = await queryInterxStatusService.getHealth(networkUri);
    return networkHealthStatus == NetworkHealthStatus.online;
  }

  Future<bool> connect(NetworkModel networkModel) async {
    try {
      final InterxResponseData interxStatusResponse = await queryInterxStatusService.getData(networkModel.parsedUri);
      final NetworkModel newNetwork = networkModel.copyWith(
        url: interxStatusResponse.usedUri.toString(),
        queryInterxStatus: interxStatusResponse.queryInterxStatusResp,
        status: NetworkHealthStatus.online,
      );
      networkProvider.changeCurrentNetwork(newNetwork);
      emit(NetworkConnectorConnectedState(currentNetwork: newNetwork));
      return true;
    } catch (e) {
      // InterxUnavailableException
      AppLogger().log(message: e.toString(), logLevel: LogLevel.error);
      return false;
    }
  }

  void disconnect() {
    networkProvider.changeCurrentNetwork(null);
    emit(NetworkConnectorInitialState());
  }
}
