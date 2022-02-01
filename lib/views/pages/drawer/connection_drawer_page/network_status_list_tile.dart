import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/generated/assets.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:provider/provider.dart';

enum NetworkStatusEnum {
  connecting,
  connected,
  hover,
  disconnected,
}

class NetworkStatusListTile extends StatefulWidget {
  final NetworkModel networkModel;

  const NetworkStatusListTile({
    required this.networkModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkStatusListTile();
}

class _NetworkStatusListTile extends State<NetworkStatusListTile> {
  Set<NetworkStatusEnum> tileStatus = <NetworkStatusEnum>{};
  late NetworkModel currentNetworkModel;

  @override
  void initState() {
    currentNetworkModel = widget.networkModel;
    _setInitialItemStatus();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NetworkStatusListTile oldWidget) {
    currentNetworkModel = widget.networkModel;
    _setInitialItemStatus();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      onHover: (bool val) => _onHover(status: val),
      child: ListTile(
        title: Text(
          currentNetworkModel.name,
          overflow: TextOverflow.ellipsis,
        ),
        leading: _buildNetworkHealthStatusWidget(),
        trailing: _buildNetworkConnectionStatusWidget(),
      ),
    );
  }

  void _setInitialItemStatus() {
    NetworkProvider networkProvider = globalLocator<NetworkProvider>();
    if (networkProvider.isConnected && networkProvider.networkModel!.parsedUri == currentNetworkModel.parsedUri) {
      tileStatus
        ..remove(NetworkStatusEnum.disconnected)
        ..add(NetworkStatusEnum.connected);
    } else {
      tileStatus
        ..remove(NetworkStatusEnum.connected)
        ..add(NetworkStatusEnum.disconnected);
    }
  }

  Future<void> _onTap() async {
    if (currentNetworkModel.isConnected) {
      _disconnectFromNetwork();
    } else {
      await _connectToNetwork();
    }
  }

  void _disconnectFromNetwork() {
    context.read<NetworkConnectorCubit>().disconnect();
    tileStatus
      ..remove(NetworkStatusEnum.connected)
      ..add(NetworkStatusEnum.disconnected);
  }

  Future<void> _connectToNetwork() async {
    tileStatus.add(NetworkStatusEnum.connecting);
    setState(() {});
    bool status = await context.read<NetworkConnectorCubit>().connect(widget.networkModel);
    if (!status) {
      setState(() {
        currentNetworkModel = currentNetworkModel.copyWith(status: NetworkHealthStatus.offline);
      });
    }
    tileStatus.remove(NetworkStatusEnum.connecting);
    setState(() {});
  }

  void _onHover({required bool status}) {
    if (status) {
      tileStatus.add(NetworkStatusEnum.hover);
    } else {
      tileStatus.remove(NetworkStatusEnum.hover);
    }
    setState(() {});
  }

  // TODO(dpajak99): After UI, move it to single widget
  Widget _buildNetworkHealthStatusWidget() {
    switch (currentNetworkModel.status) {
      case NetworkHealthStatus.online:
        return SvgPicture.asset(
          Assets.iconsNetworkStatus,
          color: Colors.green,
          height: 15,
        );
      case NetworkHealthStatus.waiting:
        return SvgPicture.asset(
          Assets.iconsNetworkStatus,
          color: Colors.grey,
          height: 15,
        );
      default:
        return SvgPicture.asset(
          Assets.iconsNetworkStatus,
          color: Colors.red,
          height: 14,
        );
    }
  }

  Widget? _buildNetworkConnectionStatusWidget() {
    if (tileStatus.contains(NetworkStatusEnum.connecting)) {
      return const Text('Connecting...');
    }
    if (tileStatus.contains(NetworkStatusEnum.hover)) {
      if (tileStatus.contains(NetworkStatusEnum.disconnected)) {
        return const Text('Connect');
      }
      if (tileStatus.contains(NetworkStatusEnum.connected)) {
        return const Text('Disconnect');
      }
    }
    if (tileStatus.contains(NetworkStatusEnum.connected)) {
      return const Text('Connected');
    }
    return null;
  }
}
