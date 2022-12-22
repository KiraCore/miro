import 'package:flutter/material.dart';
import 'package:miro/config/app_sizes.dart';
import 'package:miro/views/widgets/generic/filled_scroll_view.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class PageLayout extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final bool expandScroll;

  const PageLayout({
    required this.child,
    required this.scrollController,
    this.expandScroll = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PageLayout();
}

class _PageLayout extends State<PageLayout> {
  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    child = Padding(
      padding: padding,
      child: child,
    );

    if (widget.expandScroll) {
      child = FilledScrollView(scrollController: widget.scrollController, child: child);
    } else {
      child = SingleChildScrollView(controller: widget.scrollController, child: child);
    }

    return child;
  }

  EdgeInsets get padding {
    if (ResponsiveWidget.isLargeScreen(context)) {
      return AppSizes.defaultDesktopPageMargin;
    } else {
      return AppSizes.defaultMobilePageMargin;
    }
  }
}
