import 'package:flutter/cupertino.dart';

class PopWrapperController {
  final ValueNotifier<bool> isTooltipVisibleNotifier = ValueNotifier<bool>(false);

  void showTooltip() {
    isTooltipVisibleNotifier.value = true;
  }

  void hideTooltip() {
    isTooltipVisibleNotifier.value = false;
  }

  void invertVisibility() {
    isTooltipVisibleNotifier.value = !isTooltipVisibleNotifier.value;
  }
}
