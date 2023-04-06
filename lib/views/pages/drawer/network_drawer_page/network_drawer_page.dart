import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
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
        children: <Widget>[
          DrawerTitle(
            title: S.of(context).networkChoose,
            tooltipMessage: S.of(context).networkList,
          ),
          const SizedBox(height: 28),
          const NetworkList(),
          const NetworkCustomSection(),
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}
