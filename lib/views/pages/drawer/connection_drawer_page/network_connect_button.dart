import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/network_model.dart';

class NetworkConnectButton extends StatefulWidget {
  final NetworkModel networkModel;
  final bool isConnected;

  const NetworkConnectButton({
    required this.networkModel,
    this.isConnected = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkConnectButton();
}

class _NetworkConnectButton extends State<NetworkConnectButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isConnected) {
      return _buildConnectedButton();
    }
    if (widget.networkModel.status == NetworkHealthStatus.online) {
      return _buildConnectButton();
    }
    if (widget.networkModel.status == NetworkHealthStatus.unknown) {
      return _buildConnectButton(opacity: 0.3, canConnect: false);
    }
    return const Text(
      'Cannot connect to network',
      style: TextStyle(
        color: DesignColors.red_100,
      ),
    );
  }

  Widget _buildConnectedButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          DesignColors.darkGreen,
        ),
      ),
      child: Text(
        'Connected'.toUpperCase(),
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildConnectButton({double opacity = 1, bool canConnect = true}) {
    return Opacity(
      opacity: opacity,
      child: OutlinedButton(
        onPressed: canConnect ? _connectToNetwork : null,
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              side: BorderSide(
                color: DesignColors.darkGreen,
              ),
            ),
          ),
        ),
        child: Text(
          'Connect'.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Future<void> _connectToNetwork() async {
    await BlocProvider.of<NetworkConnectorCubit>(context).connect(widget.networkModel);
  }
}
