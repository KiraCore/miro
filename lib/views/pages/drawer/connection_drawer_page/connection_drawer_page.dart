import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/blocs/specific_blocs/network_list/network_list_cubit.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/views/pages/drawer/connection_drawer_page/network_status_list_tile.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:provider/provider.dart';

class ConnectionDrawerPage extends StatefulWidget {
  const ConnectionDrawerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectionDrawerPage();
}

class _ConnectionDrawerPage extends State<ConnectionDrawerPage> {
  final TextEditingController customNetworkTextController = TextEditingController();
  String? errorMessage;
  String? successMessage;
  bool loadingStatus = false;
  bool customAddressVisibilityStatus = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<NetworkListCubit, NetworkListState>(
        builder: (_, NetworkListState networkListState) {
          if (networkListState is NetworkListLoadedState) {
            return Consumer<NetworkProvider>(builder: (_, NetworkProvider networkProvider, Widget? child) {
              int networkListLength = networkListState.networkList.length;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Choose a Connection', style: Theme.of(context).textTheme.headline1),
                  const SizedBox(height: 28),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: networkListLength,
                    itemBuilder: (_, int index) {
                      NetworkModel currentNetwork = networkListState.networkList[index];
                      return NetworkStatusListTile(
                        networkModel: currentNetwork,
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Enable custom address', style: Theme.of(context).textTheme.headline2),
                        Switch(
                          value: customAddressVisibilityStatus,
                          onChanged: _onChangedCustomAddressValue,
                        )
                      ],
                    ),
                  ),
                  if (customAddressVisibilityStatus) ...<Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: customNetworkTextController,
                            decoration: InputDecoration(
                              hintText: 'Custom',
                              suffixIcon: TextButton(
                                onPressed: _connectCustomNetwork,
                                child: const Text('Connect'),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                              child: const Text('Try connection'),
                            ),
                          ),
                          if (loadingStatus) const CenterLoadSpinner(size: 15) else const SizedBox(),
                        ],
                      ),
                    ),
                    if (errorMessage != null) Text(errorMessage!, style: const TextStyle(color: Colors.red)),
                    if (successMessage != null) Text(successMessage!, style: const TextStyle(color: Colors.green)),
                  ],
                ],
              );
            });
          }
          return const CenterLoadSpinner();
        },
      ),
    );
  }

  void _onChangedCustomAddressValue(bool value) {
    setState(() {
      customAddressVisibilityStatus = value;
    });
  }

  Future<void> _connectCustomNetwork() async {
    if (!_validateNetworkUrl()) {
      return;
    }
    String networkUrl = customNetworkTextController.text;
    _setLoadingStatus(true);
    bool status = await context.read<NetworkConnectorCubit>().connect(
          NetworkModel(
            url: networkUrl,
            name: 'custom network',
            status: NetworkHealthStatus.offline,
          ),
        );
    _setLoadingStatus(false);
    if (status) {
      _updateSuccessMessage('Successfully connected');
    } else {
      _updateErrorMessage('Cannot connect');
    }
  }

  Future<void> _validateNetworkConnection() async {
    if (!_validateNetworkUrl()) {
      return;
    }
    String networkUrl = customNetworkTextController.text;
    _setLoadingStatus(true);
    if (await context.read<NetworkConnectorCubit>().checkConnection(networkUrl)) {
      _updateSuccessMessage('Success');
    } else {
      _updateErrorMessage('Cannot connect');
    }
    _setLoadingStatus(false);
  }

  bool _validateNetworkUrl() {
    String networkUrl = customNetworkTextController.text;
    if (networkUrl.isEmpty) {
      _updateErrorMessage('Field cannot be empty');
      return false;
    }
    return true;
  }

  void _setLoadingStatus(bool status) {
    setState(() {
      loadingStatus = status;
    });
  }

  void _updateSuccessMessage(String message) {
    setState(() {
      errorMessage = null;
      loadingStatus = false;
      successMessage = message;
    });
  }

  void _updateErrorMessage(String message) {
    setState(() {
      errorMessage = message;
      loadingStatus = false;
      successMessage = null;
    });
  }
}
