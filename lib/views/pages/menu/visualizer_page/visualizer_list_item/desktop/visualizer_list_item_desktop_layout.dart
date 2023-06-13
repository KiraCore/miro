import 'package:flutter/cupertino.dart';

class VisualizerListItemDesktopLayout extends StatelessWidget {
  final double height;
  final Widget monikerWidget;
  final Widget ipWidget;
  final Widget peersWidget;
  final Widget countryWidget;
  final Widget dataCenterWidget;

  const VisualizerListItemDesktopLayout({
    required this.height,
    required this.monikerWidget,
    required this.ipWidget,
    required this.peersWidget,
    required this.countryWidget,
    required this.dataCenterWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          Expanded(flex: 3, child: monikerWidget),
          Expanded(flex: 2, child: ipWidget),
          Expanded(flex: 1, child: peersWidget),
          Expanded(flex: 2, child: countryWidget),
          Expanded(flex: 2, child: dataCenterWidget),
        ],
      ),
    );
  }
}
