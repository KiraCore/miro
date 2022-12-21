import 'package:flutter/material.dart';
import 'package:miro/views/layout/drawer/drawer_subtitle.dart';
import 'package:miro/views/widgets/network_list/network_custom_section/network_custom_section.dart';
import 'package:miro/views/widgets/network_list/network_list.dart';

class NetworkDrawerPage extends StatefulWidget {
  const NetworkDrawerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NetworkDrawerPage();
}

class _NetworkDrawerPage extends State<NetworkDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          DrawerTitle(
            title: 'Choose network',
            tooltipMessage: 'This is a list of networks',
          ),
          SizedBox(height: 28),
          NetworkList(),
          NetworkCustomSection(),
          SizedBox(height: 150),
        ],
      ),
    );
  }
}
