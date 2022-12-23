import 'package:flutter/cupertino.dart';

class ValidatorListItemDesktopLayout extends StatelessWidget {
  final double height;
  final Widget favouriteButtonWidget;
  final Widget topWidget;
  final Widget monikerWidget;
  final Widget statusWidget;
  final Widget uptimeWidget;
  final Widget streakWidget;

  const ValidatorListItemDesktopLayout({
    required this.height,
    required this.favouriteButtonWidget,
    required this.topWidget,
    required this.monikerWidget,
    required this.statusWidget,
    required this.uptimeWidget,
    required this.streakWidget,
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
          SizedBox(width: 100, child: favouriteButtonWidget),
          Expanded(child: topWidget),
          Expanded(flex: 3, child: monikerWidget),
          Expanded(flex: 2, child: statusWidget),
          Expanded(flex: 2, child: uptimeWidget),
          Expanded(flex: 2, child: streakWidget),
        ],
      ),
    );
  }
}
