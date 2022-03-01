import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/providers/network_provider/network_events.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/network_provider/network_states.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class LoadingPage extends StatefulWidget {
  final RouteMatch<dynamic>? nextRoute;

  const LoadingPage({
    this.nextRoute,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoadingPage();
}

class _LoadingPage extends State<LoadingPage> {
  NetworkProvider networkProvider = globalLocator<NetworkProvider>();
  Completer<void> pageCompleter = Completer<void>();

  @override
  void initState() {
    networkProvider.addListener(_onNetworkConnected);
    _setMinimalPageDuration();
    super.initState();
  }

  @override
  void dispose() {
    networkProvider.removeListener(_onNetworkConnected);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logo_loading.gif',
            height: 130,
            width: 130,
          ),
          const SizedBox(height: 50),
          Text(
            'Connecting to ${_getNetworkName()}. Please wait...',
            style: const TextStyle(
              color: DesignColors.white_100,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 67),
          KiraOutlinedButton(
            width: 192,
            title: 'Cancel connection',
            onPressed: _onCancelConnection,
          )
        ],
      ),
    );
  }

  Future<void> _setMinimalPageDuration() async {
    await Future<void>.delayed(const Duration(seconds: 4)).then((_) => pageCompleter.complete());
  }

  String _getNetworkName() {
    NetworkState networkState = networkProvider.state;
    if (networkState is ConnectingNetworkState) {
      return networkState.networkModel.parsedUri.host;
    }

    return 'network';
  }

  Future<void> _onCancelConnection() async {
    networkProvider.handleEvent(DisconnectNetworkEvent(notify: false));
    await AutoRouter.of(context).replace(ConnectionsRoute(nextRoute: widget.nextRoute));
  }

  Future<void> _onNetworkConnected() async {
    if (mounted) {
      await pageCompleter.future;
      if (widget.nextRoute != null) {
        await AutoRouter.of(context).replace(PageRouteInfo<dynamic>.fromMatch(widget.nextRoute!));
      } else {
        await AutoRouter.of(context).replace(const PagesRoute());
      }
    }
  }
}
