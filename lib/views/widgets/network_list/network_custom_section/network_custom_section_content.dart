import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/a_network_online_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class NetworkCustomSectionContent extends StatefulWidget {
  final ValueChanged<ANetworkStatusModel>? onConnected;

  const NetworkCustomSectionContent({
    this.onConnected,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkCustomSectionContent();
}

class _NetworkCustomSectionContent extends State<NetworkCustomSectionContent> {
  final AppConfig appConfig = globalLocator<AppConfig>();
  final NetworkModuleBloc networkModuleBloc = globalLocator<NetworkModuleBloc>();
  final NetworkModuleService networkModuleService = globalLocator<NetworkModuleService>();
  final TextEditingController textEditingController = TextEditingController();
  String? errorMessage;
  String? successMessage;
  bool loadingStatus = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: 'Custom address',
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              hintStyle: const TextStyle(
                color: DesignColors.white_100,
                fontSize: 16,
              ),
              suffixIcon: TextButton(
                onPressed: _handleConnectButtonPressed,
                child: const Text(
                  'Connect',
                  style: TextStyle(color: DesignColors.darkGreen_100),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: const TextStyle(
              color: DesignColors.red_100,
              fontSize: 12,
            ),
          ),
        if (successMessage != null)
          Text(
            successMessage!,
            style: const TextStyle(
              color: DesignColors.darkGreen_100,
              fontSize: 12,
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: _handleTryConnectionButtonPressed,
                  child: const Text(
                    'Try connection',
                    style: TextStyle(
                      color: DesignColors.gray2_100,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              if (loadingStatus) const CenterLoadSpinner(size: 15) else const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handleConnectButtonPressed() async {
    _clearMessages();
    Uri? networkUri = _tryGetNetworkUri();
    if (networkUri == null) {
      return;
    }
    ANetworkStatusModel? networkStatusModel = await _getNetworkStatusModel(networkUri);
    if (networkStatusModel is ANetworkOnlineModel) {
      successMessage = 'Connected';
      networkModuleBloc.add(NetworkModuleConnectEvent(networkStatusModel));
      widget.onConnected?.call(networkStatusModel);
    } else {
      errorMessage = "Can't connect to network";
    }
    setState(() {});
  }

  Future<void> _handleTryConnectionButtonPressed() async {
    _clearMessages();
    Uri? networkUri = _tryGetNetworkUri();
    if (networkUri == null) {
      return;
    }

    ANetworkStatusModel? networkStatusModel = await _getNetworkStatusModel(networkUri);
    if (networkStatusModel is ANetworkOnlineModel) {
      successMessage = 'Can connect to network';
    } else {
      errorMessage = "Can't connect to network";
    }
    setState(() {});
  }

  void _clearMessages() {
    successMessage = null;
    errorMessage = null;
    setState(() {});
  }

  Future<ANetworkStatusModel?> _getNetworkStatusModel(Uri networkUri) async {
    setState(() {
      loadingStatus = true;
    });
    NetworkUnknownModel? networkUnknownModel = NetworkUnknownModel(uri: networkUri, connectionStatusType: ConnectionStatusType.disconnected);
    networkUnknownModel = appConfig.findNetworkModelInConfig(networkUnknownModel);
    ANetworkStatusModel networkStatusModel = await networkModuleService.getNetworkStatusModel(
      networkUnknownModel,
    );
    setState(() {
      loadingStatus = false;
    });
    return networkStatusModel;
  }

  Uri? _tryGetNetworkUri() {
    try {
      String networkAddress = textEditingController.text;
      if (networkAddress.isEmpty) {
        throw Error();
      }
      Uri networkUri = NetworkUtils.parseUrl(networkAddress);
      return networkUri;
    } catch (_) {
      errorMessage = 'Please enter a valid network address';
      setState(() {});
      return null;
    }
  }
}
