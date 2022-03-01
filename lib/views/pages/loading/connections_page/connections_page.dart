import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/providers/network_provider/network_events.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/router/router.gr.dart';
import 'package:miro/views/pages/drawer/connection_drawer_page/custom_network_section.dart';
import 'package:miro/views/pages/drawer/connection_drawer_page/network_list.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';

class ConnectionsPage extends StatefulWidget {
  final RouteMatch<dynamic>? nextRoute;

  const ConnectionsPage({
    this.nextRoute,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectionsPage();
}

class _ConnectionsPage extends State<ConnectionsPage> {
  @override
  void initState() {
    globalLocator<NetworkProvider>().handleEvent(DisconnectNetworkEvent(notify: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48, left: 48, right: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              KiraOutlinedButton(
                width: 125,
                onPressed: () {},
                title: 'Needs help?',
              ),
            ],
          ),
          const SizedBox(height: 50),
          Expanded(
            child: SizedBox(
              width: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 40,
                    height: 42,
                    child: Image.asset(
                      'assets/logo_sygnet.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Connection cancelled',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Select available networks',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          NetworkList(
                            onNetworkConnected: _onNetworkConnected,
                          ),
                          CustomNetworkSection(
                            onNetworkConnected: _onNetworkConnected,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onNetworkConnected(NetworkModel networkModel) {
    if (widget.nextRoute != null) {
      AutoRouter.of(context).replace(PageRouteInfo<dynamic>.fromMatch(widget.nextRoute!));
    } else {
      AutoRouter.of(context).replace(const PagesRoute(
        children: <PageRouteInfo>[DashboardRoute()],
      ));
    }
  }
}
