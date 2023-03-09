import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

class ToastDecoration {
  final Color backgroundColor;
  final Color titleColor;
  final Color iconColor;
  final Color actionButtonBorderColor;

  const ToastDecoration({
    required this.backgroundColor,
    required this.titleColor,
    required this.iconColor,
    required this.actionButtonBorderColor,
  });

  factory ToastDecoration.fromToastType(ToastType toastType) {
    switch (toastType) {
      case ToastType.success:
        return const ToastDecoration(
          backgroundColor: DesignColors.greenStatus2,
          titleColor: DesignColors.greenStatus1,
          iconColor: DesignColors.greenStatus1,
          actionButtonBorderColor: DesignColors.greenStatus1,
        );
      case ToastType.error:
        return const ToastDecoration(
          backgroundColor: DesignColors.redStatus3,
          titleColor: DesignColors.redStatus1,
          iconColor: DesignColors.redStatus1,
          actionButtonBorderColor: DesignColors.redStatus1,
        );
      case ToastType.warning:
        return const ToastDecoration(
          backgroundColor: DesignColors.yellowStatus2,
          titleColor: DesignColors.yellowStatus1,
          iconColor: DesignColors.yellowStatus1,
          actionButtonBorderColor: DesignColors.yellowStatus1,
        );
      default:
        return const ToastDecoration(
          backgroundColor: DesignColors.grey3,
          titleColor: DesignColors.white1,
          iconColor: DesignColors.white1,
          actionButtonBorderColor: DesignColors.white1,
        );
    }
  }

  ToastDecoration copyWith({
    Color? backgroundColor,
    Color? titleColor,
    Color? iconColor,
    Color? actionButtonBorderColor,
  }) {
    return ToastDecoration(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      iconColor: iconColor ?? this.iconColor,
      actionButtonBorderColor: actionButtonBorderColor ?? this.actionButtonBorderColor,
    );
  }
}
