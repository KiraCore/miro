import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/providers/network_provider/network_events.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/infra/interx_response_data.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/utils/network_utils.dart';

part 'network_connector_state.dart';

class NetworkConnectorCubit extends Cubit<NetworkConnectorState> {
  final QueryInterxStatusService queryInterxStatusService;
  final QueryValidatorsService queryValidatorsService;
  final NetworkProvider networkProvider;

  NetworkConnectorCubit({
    required this.queryInterxStatusService,
    required this.queryValidatorsService,
    required this.networkProvider,
  }) : super(NetworkConnectorInitialState()) {
    connectFromUrl();
  }

  Future<void> connectFromUrl({String? url}) async {
    final Uri baseUri = url != null ? NetworkUtils.parseUrl(url) : Uri.base;
    final String? networkSrc = baseUri.queryParameters['rpc'];

    if (networkSrc != null) {
      NetworkModel networkToConnect = NetworkModel(
        url: networkSrc,
        name: networkSrc,
        status: NetworkHealthStatus.unknown,
      );
      networkProvider.handleEvent(ConnectToNetworkEvent(networkToConnect));
      NetworkModel urlNetworkModel = await getNetworkData(networkToConnect);

      if (urlNetworkModel.status == NetworkHealthStatus.online) {
        await connect(urlNetworkModel);
      }
    }
  }

  Future<void> connect(NetworkModel networkModel) async {
    networkProvider
      ..handleEvent(ConnectToNetworkEvent(networkModel))
      ..handleEvent(SetUpNetworkEvent(networkModel));
    emit(NetworkConnectorConnectedState(currentNetwork: networkModel));
  }

  Future<NetworkModel> getNetworkData(NetworkModel network) async {
    try {
      InterxResponseData interxResponseData = await queryInterxStatusService.getData(network.parsedUri);
      QueryValidatorsResp queryValidatorsResp = await queryValidatorsService.getValidators(
        interxResponseData.usedUri,
        QueryValidatorsReq(all: true),
      );
      return network.copyWith(
        url: interxResponseData.usedUri.toString(),
        status: NetworkHealthStatus.online,
        queryValidatorsResp: queryValidatorsResp,
        queryInterxStatus: interxResponseData.queryInterxStatusResp,
      );
    } catch (e) {
      if (networkProvider.isConnected && networkProvider.networkUri == network.parsedUri) {
        disconnect();
      }
      return network.copyWith(
        status: NetworkHealthStatus.offline,
      );
    }
  }

  void disconnect() {
    networkProvider.handleEvent(DisconnectNetworkEvent());
    emit(NetworkConnectorInitialState());
  }
}
