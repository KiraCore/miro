import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_desktop.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

typedef PopWrapperBuilder = Widget Function();

class PopWrapper extends StatefulWidget {
  final PopWrapperBuilder buttonBuilder;
  final PopWrapperBuilder popupBuilder;
  final PopWrapperController popWrapperController;
  final bool disabled;

  const PopWrapper({
    required this.buttonBuilder,
    required this.popupBuilder,
    required this.popWrapperController,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopWrapperState();
}

class _PopWrapperState extends State<PopWrapper> {
  final JustTheController justTheController = JustTheController();

  @override
  Widget build(BuildContext context) {
    Widget desktopWidget = PopWrapperDesktop(
      justTheController: justTheController,
      buttonBuilder: widget.buttonBuilder,
      popupBuilder: widget.popupBuilder,
      popWrapperController: widget.popWrapperController,
      disabled: widget.disabled,
      backgroundColor: DesignColors.black,
    );
    Widget mobileWidget = PopWrapperMobile(
      buttonBuilder: widget.buttonBuilder,
      popupBuilder: widget.popupBuilder,
      popWrapperController: widget.popWrapperController,
      disabled: widget.disabled,
      backgroundColor: DesignColors.black,
    );

    return ResponsiveWidget(
      largeScreen: desktopWidget,
      mediumScreen: mobileWidget,
      smallScreen: mobileWidget,
    );
  }
}
