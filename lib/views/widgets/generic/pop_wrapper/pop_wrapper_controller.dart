import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:miro/views/widgets/generic/responsive/screen_size.dart';

class PopWrapperController {
  late BuildContext context;
  late ScreenSize _screenSize;
  late AnimationController animationController;
  late JustTheController controller = JustTheController();
  late Function showMobilePopup;

  set screenSize(ScreenSize value) {
    _screenSize = value;
  }

  void showMenu() {
    if (_screenSize == ScreenSize.desktop) {
      controller.showTooltip();
    } else {
      showMobilePopup();
    }
  }

  void hideMenu() {
    if (_screenSize == ScreenSize.desktop) {
      controller.hideTooltip();
    } else {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  void toggleMenu() {
    if (controller.value == TooltipStatus.isShowing) {
      hideMenu();
    } else {
      showMenu();
    }
  }

  void dispose() {
    animationController.dispose();
  }

  void initController({
    required AnimationController animationController,
    required BuildContext context,
    required Function showMobilePopup,
  }) {
    this.animationController = animationController;
    this.context = context;
    this.showMobilePopup = showMobilePopup;
  }
}
