import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/generic/responsive/screen_size.dart';

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

  static bool isSmallScreen(BuildContext context) => MediaQuery.of(context).size.width < 850;

  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;

  static bool isLargeScreen(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  static ScreenSize getScreenSize(BuildContext context) {
    if (isSmallScreen(context)) {
      return ScreenSize.mobile;
    }

    if (isMediumScreen(context)) {
      return ScreenSize.tablet;
    }

    return ScreenSize.desktop;
  }

  @override
  Widget build(BuildContext context) {
    // If our width is more than 1100, we assume it is a desktop
    if (isLargeScreen(context)) {
      return largeScreen;
    }
    // If width is less than 1100 and more than 850, we assume it is a tablet
    else if (isMediumScreen(context) && smallScreen != null) {
      return smallScreen!;
    }
    // Or less than 850, we assume it is a mobile
    else {
      return mediumScreen;
    }
  }
}
