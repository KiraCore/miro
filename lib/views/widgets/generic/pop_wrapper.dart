import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:miro/views/widgets/generic/responsive/responsive_widget.dart';
import 'package:miro/views/widgets/generic/responsive/screen_size.dart';

typedef PopWrapperButtonBuilder = Widget Function(AnimationController animationController);

typedef PopWrapperPopupBuilder = Widget Function();

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

class PopWrapper extends StatefulWidget {
  final PopWrapperController popWrapperController;
  final PopWrapperPopupBuilder popupBuilder;
  final PopWrapperButtonBuilder buttonBuilder;
  final double dropdownMargin;
  final BoxDecoration? decoration;
  final double buttonWidth;
  final double buttonHeight;

  const PopWrapper({
    required this.popWrapperController,
    required this.buttonBuilder,
    required this.popupBuilder,
    required this.buttonWidth,
    required this.buttonHeight,
    this.dropdownMargin = 15,
    this.decoration,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopWrapper();
}

class _PopWrapper extends State<PopWrapper> with SingleTickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  @override
  void initState() {
    super.initState();
    animationController.addListener(_handleAnimationControllerChanged);
    _setUpController();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updatePopWrapperController();
    return ResponsiveWidget(
      largeScreen: _buildDesktop(),
      mediumScreen: _buildMobile(),
    );
  }

  void _handleAnimationControllerChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  void _setUpController() {
    widget.popWrapperController.initController(
      animationController: animationController,
      context: context,
      showMobilePopup: _showMobilePopup,
    );
  }

  void _updatePopWrapperController() {
    widget.popWrapperController.screenSize = ResponsiveWidget.getScreenSize(context);
  }

  Widget _buildDesktop() {
    return JustTheTooltip(
      isModal: true,
      controller: widget.popWrapperController.controller,
      triggerMode: TooltipTriggerMode.manual,
      tailLength: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        margin: const EdgeInsets.only(top: 14, left: 4, right: 4, bottom: 4),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Container(
          decoration: widget.decoration,
          child: widget.popupBuilder(),
        ),
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            widget.popWrapperController.showMenu();
          },
          child: Container(
            color: Colors.transparent,
            width: widget.buttonWidth,
            height: widget.buttonHeight,
            child: widget.buttonBuilder(widget.popWrapperController.animationController),
          ),
        ),
      ),
    );
  }

  Widget _buildMobile() {
    return GestureDetector(
      onTap: _showMobilePopup,
      child: widget.buttonBuilder(widget.popWrapperController.animationController),
    );
  }

  void _showMobilePopup() {
    showDialog<void>(
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: widget.decoration?.color,
          child: widget.popupBuilder(),
        );
      },
    );
  }
}
