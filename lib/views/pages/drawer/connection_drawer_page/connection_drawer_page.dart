import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/views/pages/drawer/connection_drawer_page/custom_network_section.dart';
import 'package:miro/views/pages/drawer/connection_drawer_page/network_list.dart';
import 'package:miro/views/widgets/kira/kira_tooltip.dart';

class ConnectionDrawerPage extends StatefulWidget {
  const ConnectionDrawerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConnectionDrawerPage();
}

class _ConnectionDrawerPage extends State<ConnectionDrawerPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Text('Choose a Connection', style: Theme.of(context).textTheme.headline1),
              // TODO(dominik): Add tooltip message
              const KiraToolTip(
                message: 'Sth about networks',
              ),
            ],
          ),
          const SizedBox(height: 28),
          const NetworkList(),
          const CustomNetworkSection(),
        ],
      ),
    );
  }
}
