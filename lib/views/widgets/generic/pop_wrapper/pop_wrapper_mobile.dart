import 'package:flutter/material.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper.dart';
import 'package:miro/views/widgets/generic/pop_wrapper/pop_wrapper_controller.dart';

class PopWrapperMobile extends StatefulWidget {
  final bool disabled;
  final Color backgroundColor;
  final PopWrapperBuilder buttonBuilder;
  final PopWrapperBuilder popupBuilder;
  final PopWrapperController popWrapperController;

  const PopWrapperMobile({
    required this.disabled,
    required this.backgroundColor,
    required this.buttonBuilder,
    required this.popupBuilder,
    required this.popWrapperController,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PopWrapperMobile();
}

class _PopWrapperMobile extends State<PopWrapperMobile> {
  bool isPopupVisible = false;

  @override
  void initState() {
    super.initState();
    widget.popWrapperController.isTooltipVisibleNotifier.addListener(_updatePopupState);
  }

  @override
  void dispose() {
    widget.popWrapperController.isTooltipVisibleNotifier.removeListener(_updatePopupState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: widget.popWrapperController.showTooltip,
      childBuilder: (_) => widget.buttonBuilder(),
    );
  }

  void _updatePopupState() {
    bool shouldShowPopup = widget.popWrapperController.isTooltipVisibleNotifier.value;
    if (shouldShowPopup && isPopupVisible == false) {
      _showPopup();
    } else if (isPopupVisible && shouldShowPopup == false) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  Future<void> _showPopup() async {
    ThemeData themeData = Theme.of(context);
    if (widget.disabled) {
      return;
    }
    isPopupVisible = true;

    await showDialog<void>(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: themeData.scaffoldBackgroundColor,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 200),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            width: double.infinity,
            child: widget.popupBuilder(),
          ),
        );
      },
    );

    isPopupVisible = false;
    widget.popWrapperController.isTooltipVisibleNotifier.value = false;
  }
}
