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
  late VoidCallback showMobilePopup;

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
    required VoidCallback showMobilePopup,
  }) {
    this.animationController = animationController;
    this.context = context;
    this.showMobilePopup = showMobilePopup;
  }
}

class PopWrapper extends StatefulWidget {
  final PopWrapperButtonBuilder buttonBuilder;
  final double buttonHeight;
  final double buttonWidth;
  final PopWrapperPopupBuilder popupBuilder;
  final PopWrapperController popWrapperController;
  final BoxDecoration? decoration;
  final bool disabled;
  final double dropdownMargin;

  const PopWrapper({
    required this.buttonBuilder,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.popupBuilder,
    required this.popWrapperController,
    this.decoration,
    this.disabled = false,
    this.dropdownMargin = 15,
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
            if (widget.disabled) {
              return;
            }
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
    if (widget.disabled) {
      return;
    }
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
