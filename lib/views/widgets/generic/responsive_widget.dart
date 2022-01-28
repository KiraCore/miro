import 'package:flutter/cupertino.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({
    required this.largeScreen,
    required this.mediumScreen,
    this.smallScreen,
    Key? key,
  }) : super(key: key);

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 850;

  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    // If our width is more than 1100 then we consider it a desktop
    if (isMediumScreen(context)) {
      return largeScreen;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (isLargeScreen(context) && smallScreen != null) {
      return smallScreen!;
    }
    // Or less then that we called it mobile
    else {
      return mediumScreen;
    }
  }
}

