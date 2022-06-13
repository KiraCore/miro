import 'package:flutter/material.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/network_provider/network_states.dart';
import 'package:miro/views/widgets/generic/center_load_spinner.dart';
import 'package:provider/provider.dart';

class NetworkGuardWidget extends StatelessWidget {
  final Widget child;

  const NetworkGuardWidget({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NetworkProvider>(builder: (BuildContext context, NetworkProvider networkProvider, _) {
      if (networkProvider.state is DisconnectedNetworkState) {
        return _DisconnectedNetworkWidget();
      } else if (networkProvider.state is ConnectingNetworkState) {
        return _ConnectingNetworkWidget();
      } else {
        return child;
      }
    });
  }
}

class _DisconnectedNetworkWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text('You are not connected to any interx'),
        ],
      ),
    );
  }
}

class _ConnectingNetworkWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          CenterLoadSpinner(),
          SizedBox(height: 10),
          Text('Connecting to network...'),
        ],
      ),
    );
  }
}
