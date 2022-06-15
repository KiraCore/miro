import 'package:flutter/cupertino.dart';

class ValidatorsListItemLayout extends StatelessWidget {
  final Widget favouriteButtonSection;
  final Widget topSection;
  final Widget monikerSection;
  final Widget statusSection;

  const ValidatorsListItemLayout({
    required this.favouriteButtonSection,
    required this.topSection,
    required this.monikerSection,
    required this.statusSection,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      width: double.infinity,
      height: 64,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: favouriteButtonSection,
          ),
          Expanded(child: topSection),
          Expanded(child: monikerSection),
          Expanded(child: statusSection),
        ],
      ),
    );
  }
}
