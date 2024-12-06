import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_desktop.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_mobile.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';

class PopWrapper extends StatefulWidget {
  final Widget button;
  final Widget popup;
  final PopWrapperController popWrapperController;
  final bool disabled;

  const PopWrapper({
    required this.button,
    required this.popup,
    required this.popWrapperController,
    this.disabled = false,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopWrapperState();
}

class _PopWrapperState extends State<PopWrapper> {
  final JustTheController justTheController = JustTheController();
  late Widget desktopWidget;
  late Widget mobileWidget;

  @override
  void initState() {
    super.initState();
    desktopWidget = PopWrapperDesktop(
      justTheController: justTheController,
      button: widget.button,
      popup: widget.popup,
      popWrapperController: widget.popWrapperController,
      disabled: widget.disabled,
      backgroundColor: DesignColors.black,
    );
    mobileWidget = PopWrapperMobile(
      button: widget.button,
      popup: widget.popup,
      popWrapperController: widget.popWrapperController,
      disabled: widget.disabled,
      backgroundColor: DesignColors.black,
    );
  }

  @override
  void dispose() {
    justTheController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 10), () {
    //   desktopWidget = mobileWidget;
    //   setState(() {
    //   });
    // });

    return ResponsiveWidget(
      largeScreen: desktopWidget,
      mediumScreen: mobileWidget,
      smallScreen: mobileWidget,
    );
  }
}
