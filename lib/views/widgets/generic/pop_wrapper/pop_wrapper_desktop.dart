import 'package:el_tooltip/el_tooltip.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';
import 'package:super_tooltip/super_tooltip.dart';

final GlobalKey _popupKey = GlobalKey();

class PopWrapperDesktop extends StatefulWidget {
  final bool disabled;
  final Color backgroundColor;
  final JustTheController justTheController;
  final Widget button;
  final Widget popup;
  final PopWrapperController popWrapperController;

  const PopWrapperDesktop({
    required this.disabled,
    required this.backgroundColor,
    required this.justTheController,
    required this.button,
    required this.popup,
    required this.popWrapperController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopWrapperDesktop();
}

class _PopWrapperDesktop extends State<PopWrapperDesktop> {
  late final JustTheController justTheController;
  late ElTooltipController tooltipController;
  late SuperTooltipController superTooltipController;

  @override
  void initState() {
    super.initState();
    justTheController = JustTheController();
    tooltipController=ElTooltipController();
    superTooltipController = SuperTooltipController();
    widget.popWrapperController.isTooltipVisibleNotifier.addListener(_onPopupVisibleChanged);
  }

  @override
  Future<void> dispose() async {
    widget.popWrapperController.isTooltipVisibleNotifier.removeListener(_onPopupVisibleChanged);
    await justTheController.hideTooltip();
    justTheController.dispose();
    superTooltipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 10), () {
    //   widget.popWrapperController.isTooltipVisibleNotifier.value = false;
    //   _onPopupVisibleChanged();
    // });
    // return SuperTooltip(
    //   onShow: () => widget.popWrapperController.isTooltipVisibleNotifier.value = true,
    //   onHide: () => widget.popWrapperController.isTooltipVisibleNotifier.value = false,
    //   backgroundColor: Colors.transparent,
    //   controller: superTooltipController,
    //   content: Container(
    //     key: _popupKey,
    //     margin: const EdgeInsets.only(top: 8),
    //     decoration: BoxDecoration(
    //       color: Theme.of(context).scaffoldBackgroundColor,
    //       borderRadius: BorderRadius.circular(8),
    //       border: Border.all(color: DesignColors.grey3),
    //       boxShadow: const <BoxShadow>[
    //         BoxShadow(
    //           color: DesignColors.greyTransparent,
    //           spreadRadius: 3,
    //           blurRadius: 7,
    //           offset: Offset.zero,
    //         ),
    //       ],
    //     ),
    //     child: Container(
    //       padding: const EdgeInsets.all(3),
    //       decoration: BoxDecoration(
    //         color: widget.backgroundColor,
    //         borderRadius: BorderRadius.circular(8),
    //       ),
    //       child: widget.popup,
    //     ),
    //   ),
    //   child: MouseStateListener(
    //     onTap: widget.disabled ? null : widget.popWrapperController.showTooltip,
    //     childBuilder: (Set<MaterialState> states) {
    //       return Container(
    //         color: Colors.transparent,
    //         child: widget.button,
    //       );
    //     },
    //   ),
    // );
    // return ElTooltip(
    //   controller: tooltipController,
    //     content: Container(
    //       key: _popupKey,
    //       margin: const EdgeInsets.only(top: 8),
    //       decoration: BoxDecoration(
    //         color: Theme.of(context).scaffoldBackgroundColor,
    //         borderRadius: BorderRadius.circular(8),
    //         border: Border.all(color: DesignColors.grey3),
    //         boxShadow: const <BoxShadow>[
    //           BoxShadow(
    //             color: DesignColors.greyTransparent,
    //             spreadRadius: 3,
    //             blurRadius: 7,
    //             offset: Offset.zero,
    //           ),
    //         ],
    //       ),
    //       child: Container(
    //         padding: const EdgeInsets.all(3),
    //         decoration: BoxDecoration(
    //           color: widget.backgroundColor,
    //           borderRadius: BorderRadius.circular(8),
    //         ),
    //         child: widget.popup,
    //       ),
    //     ),
    //     child: MouseStateListener(
    //       onTap: widget.disabled ? null : widget.popWrapperController.showTooltip,
    //       childBuilder: (Set<MaterialState> states) {
    //         return Container(
    //           color: Colors.transparent,
    //           child: widget.button,
    //         );
    //       },
    //     ));
    return JustTheTooltip(
      isModal: true,
      controller: justTheController,
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
          border: Border.all(color: DesignColors.grey3),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: DesignColors.greyTransparent,
              spreadRadius: 3,
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
          child: widget.popup,
        ),
      ),
      child: MouseStateListener(
        onTap: widget.disabled ? null : widget.popWrapperController.showTooltip,
        childBuilder: (Set<MaterialState> states) {
          return Container(
            color: Colors.transparent,
            child: widget.button,
          );
        },
      ),
    );
  }

  Future<void> _onPopupVisibleChanged() async {
    if (widget.disabled) {
      return;
    }
    bool shouldShowTooltip = widget.popWrapperController.isTooltipVisibleNotifier.value;
    if (shouldShowTooltip) {
      await justTheController.showTooltip();
    } else {
      await justTheController.hideTooltip();
    }
  }
}
