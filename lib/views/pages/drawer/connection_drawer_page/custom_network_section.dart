import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/utils/app_logger.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';

class CustomNetworkSection extends StatefulWidget {
  const CustomNetworkSection({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomNetworkSection();
}

class _CustomNetworkSection extends State<CustomNetworkSection> {
  final FocusNode focusNode = FocusNode();
  bool showHint = true;
  final TextEditingController customNetworkTextController = TextEditingController();
  NetworkModel? currentCustomNetwork;
  String? errorMessage;
  String? successMessage;
  bool loadingStatus = false;
  bool customAddressVisibilityStatus = false;

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        showHint = false;
      } else {
        showHint = true;
      }
      setState(() {});
    });
    super.initState();
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
                        style: TextStyle(
                          color: DesignColors.darkGreen,
                        ),
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
                color: DesignColors.red,
                fontSize: 12,
              ),
            ),
          if (successMessage != null)
            Text(
              successMessage!,
              style: const TextStyle(
                color: DesignColors.darkGreen,
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
                    onTap: _validateNetworkConnection,
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

  void _onChangedCustomAddressValue(bool value) {
    setState(() {
      customAddressVisibilityStatus = value;
    });
  }

  Future<void> _connectCustomNetwork() async {
    String networkUrl = customNetworkTextController.text;
    if (currentCustomNetwork != null && currentCustomNetwork!.url == networkUrl) {
      await BlocProvider.of<NetworkConnectorCubit>(context).connect(currentCustomNetwork!);
      return;
    }

    NetworkModel? customNetworkModel = await _validateNetworkConnection();
    if (customNetworkModel != null) {
      await BlocProvider.of<NetworkConnectorCubit>(context).connect(customNetworkModel);
      _updateSuccessMessage('Successfully connected');
    } else {
      _updateErrorMessage('Cannot connect');
    }
    _setLoadingStatus(false);
  }

  Future<NetworkModel?> _validateNetworkConnection() async {
    bool hasError = _validateNetworkUrl() != null;
    if (hasError) {
      return null;
    }
    String networkUrl = customNetworkTextController.text;
    NetworkModel customNetworkModel = _createCustomNetworkModel(networkUrl);
    _setLoadingStatus(true);
    NetworkModel filledCustomNetworkModel = await BlocProvider.of<NetworkConnectorCubit>(context).getNetworkData(
      customNetworkModel,
    );
    if (filledCustomNetworkModel.status == NetworkHealthStatus.online) {
      currentCustomNetwork = filledCustomNetworkModel;
      _updateSuccessMessage('Success');
    } else {
      _updateErrorMessage('Cannot connect');
    }
    _setLoadingStatus(false);
    return filledCustomNetworkModel;
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

  NetworkModel _createCustomNetworkModel(String url) {
    return NetworkModel(
      name: 'CUSTOM NETWORK',
      url: url,
      status: NetworkHealthStatus.offline,
    );
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
