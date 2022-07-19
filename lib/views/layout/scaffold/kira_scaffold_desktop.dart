import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';

class KiraScaffoldDesktop extends StatelessWidget {
  final Widget body;
  final Widget navMenu;
  final Widget appBar;

  const KiraScaffoldDesktop({
    required this.body,
    required this.navMenu,
    required this.appBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          color: DesignColors.blue1_10,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: navMenu,
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              appBar,
              Expanded(child: body),
            ],
          ),
        ),
      ],
    );
  }
}
