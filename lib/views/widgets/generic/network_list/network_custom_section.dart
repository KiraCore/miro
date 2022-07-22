import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_set_up_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/infra/services/network_module_service.dart';
import 'package:miro/shared/models/network/status/a_network_status_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class NetworkCustomSection extends StatefulWidget {
  const NetworkCustomSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkCustomSection();
}

class _NetworkCustomSection extends State<NetworkCustomSection> {
  final TextEditingController customNetworkTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool customAddressVisibilityStatus = false;
  bool loadingStatus = false;
  bool showHint = true;

  String? errorMessage;
  String? successMessage;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusNodeChanged);
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusNodeChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Enable custom address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: DesignColors.white_100,
                ),
              ),
              Switch(
                value: customAddressVisibilityStatus,
                onChanged: _onChangedCustomAddressValue,
              ),
            ],
          ),
        ),
        if (customAddressVisibilityStatus) ...<Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  focusNode: focusNode,
                  controller: customNetworkTextController,
                  decoration: InputDecoration(
                    hintText: showHint ? 'Custom: ' : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    hintStyle: const TextStyle(
                      color: DesignColors.white_100,
                      fontSize: 16,
                    ),
                    suffixIcon: TextButton(
                      onPressed: _connectCustomNetwork,
                      child: const Text(
                        'Connect',
                        style: TextStyle(color: DesignColors.darkGreen_100),
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
                    onTap: _tryConnection,
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
      ],
    );
  }

  void _handleFocusNodeChanged() {
    if (!mounted) {
      return;
    }
    if (focusNode.hasFocus) {
      showHint = false;
    } else {
      showHint = true;
    }
    setState(() {});
  }

  void _onChangedCustomAddressValue(bool value) {
    setState(() {
      customAddressVisibilityStatus = value;
    });
  }

  Future<void> _tryConnection() async {
    _setLoadingStatus(true);
    ANetworkStatusModel? customNetworkStatusModel = await _buildNetworkStatusModel();
    _setLoadingStatus(false);
    if (customNetworkStatusModel is NetworkHealthyModel) {
      _updateSuccessMessage('Network correct');
    } else if (customNetworkStatusModel is NetworkUnhealthyModel) {
      _updateSuccessMessage('Network correct, but gets some warnings');
    } else {
      _updateErrorMessage('Cannot connect');
    }
  }

  Future<void> _connectCustomNetwork() async {
    _setLoadingStatus(true);
    ANetworkStatusModel? customNetworkStatusModel = await _buildNetworkStatusModel();
    _setLoadingStatus(false);
    if (customNetworkStatusModel is NetworkHealthyModel) {
      globalLocator<NetworkModuleBloc>().add(NetworkModuleSetUpEvent(customNetworkStatusModel));
      _updateSuccessMessage('Successfully connected');
    } else if (customNetworkStatusModel is NetworkUnhealthyModel) {
      globalLocator<NetworkModuleBloc>().add(NetworkModuleSetUpEvent(customNetworkStatusModel));
      _updateSuccessMessage('Connected with warnings');
    } else {
      _updateErrorMessage('Cannot connect');
    }
  }

  Future<ANetworkStatusModel?> _buildNetworkStatusModel() async {
    bool hasError = _validateNetworkUrl() != null;
    if (hasError) {
      return null;
    }
    Uri networkUri = NetworkUtils.parseUrl(customNetworkTextController.text);
    try {
      NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(uri: networkUri);
      ANetworkStatusModel networkStatusModel = await globalLocator<NetworkModuleService>().getNetworkStatusModel(
        networkUnknownModel,
      );
      return networkStatusModel;
    } catch (_) {
      AppLogger().log(message: 'Cannot connect to network: $networkUri');
      return null;
    }
  }

  String? _validateNetworkUrl() {
    String networkUrl = customNetworkTextController.text;
    if (networkUrl.isEmpty) {
      String errorMessage = 'Field cannot be empty';
      AppLogger().log(message: errorMessage);
      _updateErrorMessage(errorMessage);
      return errorMessage;
    }
    try {
      NetworkUtils.parseUrl(networkUrl);
    } catch (_) {
      String errorMessage = 'Cannot parse URL';
      AppLogger().log(message: errorMessage);
      _updateErrorMessage(errorMessage);
      return errorMessage;
    }
    return null;
  }

  void _setLoadingStatus(bool status) {
    setState(() {
      loadingStatus = status;
    });
  }

  void _updateErrorMessage(String message) {
    setState(() {
      errorMessage = message;
      loadingStatus = false;
      successMessage = null;
    });
  }

  void _updateSuccessMessage(String message) {
    setState(() {
      errorMessage = null;
      loadingStatus = false;
      successMessage = message;
    });
  }
}
