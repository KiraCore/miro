import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';

final GlobalKey _popupKey = GlobalKey();

class PopWrapperDesktop extends StatefulWidget {
  final bool disabled;
  final Size buttonSize;
  final Color backgroundColor;
  final JustTheController justTheController;
  final PopWrapperBuilder buttonBuilder;
  final PopWrapperBuilder popupBuilder;
  final PopWrapperController popWrapperController;

  const PopWrapperDesktop({
    required this.disabled,
    required this.buttonSize,
    required this.backgroundColor,
    required this.justTheController,
    required this.buttonBuilder,
    required this.popupBuilder,
    required this.popWrapperController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopWrapperDesktop();
}

class _PopWrapperDesktop extends State<PopWrapperDesktop> {

  @override
  void initState() {
    super.initState();
    widget.popWrapperController.isTooltipVisibleNotifier.addListener(_onPopupVisibleChanged);
  }

  @override
  void dispose() {
    widget.popWrapperController.isTooltipVisibleNotifier.removeListener(_onPopupVisibleChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      isModal: true,
      controller: widget.justTheController,
      triggerMode: TooltipTriggerMode.manual,
      onShow: () => widget.popWrapperController.isTooltipVisibleNotifier.value = true,
      onDismiss: () => widget.popWrapperController.isTooltipVisibleNotifier.value = false,
      tailLength: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        key: _popupKey,
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset.zero,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.popupBuilder(),
        ),
      ),
      child: MouseStateListener(
        onTap: widget.popWrapperController.showTooltip,
        childBuilder: (Set<MaterialState> states) {
          return Container(
            width: widget.buttonSize.width,
            height: widget.buttonSize.height,
            color: Colors.transparent,
            child: widget.buttonBuilder(),
          );
        },
      ),
    );
  }

  void _onPopupVisibleChanged() {
    if (widget.disabled) {
      return;
    }
    bool shouldShowTooltip = widget.popWrapperController.isTooltipVisibleNotifier.value;
    if (shouldShowTooltip) {
      widget.justTheController.showTooltip();
    } else {
      widget.justTheController.hideTooltip();
    }
  }
}
