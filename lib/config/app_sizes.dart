import 'package:flutter/cupertino.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class AppSizes {
  static const double desktopAppbarHeight = 80;
  static const double mobileAppbarHeight = 80;
  static const double navMenuItemHeight = 55;
  static const double sidebarDesktopWidth = 252;

  static const EdgeInsets defaultDesktopPageMargin = EdgeInsets.only(
    top: 40,
    left: 40,
    right: 40,
  );

  static const EdgeInsets defaultMobilePageMargin = EdgeInsets.only(
    top: 40,
    left: 15,
    right: 15,
  );

  static EdgeInsets getPagePadding(BuildContext context) {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return AppSizes.defaultDesktopPageMargin;
    } else {
      return AppSizes.defaultMobilePageMargin;
    }
  }
}
