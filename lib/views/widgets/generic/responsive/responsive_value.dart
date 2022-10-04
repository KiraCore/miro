import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class ResponsiveValue<T> {
  final T largeScreen;
  final T smallScreen;
  final T? mediumScreen;

  const ResponsiveValue({
    required this.largeScreen,
    required this.smallScreen,
    this.mediumScreen,
  });

  T get(BuildContext context) {
    if (ResponsiveWidget.isSmallScreen(context)) {
      return smallScreen;
    } else if (ResponsiveWidget.isMediumScreen(context)) {
      return mediumScreen ?? largeScreen;
    } else {
      return largeScreen;
    }
  }
}
