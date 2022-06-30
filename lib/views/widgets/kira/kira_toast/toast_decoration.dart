import 'package:flutter/material.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

class ToastDecoration {
  final Color backgroundColor;
  final Color titleColor;
  final Color iconColor;
  final Color actionButtonBorderColor;

  ToastDecoration({
    required this.backgroundColor,
    required this.titleColor,
    required this.iconColor,
    required this.actionButtonBorderColor,
  });

  factory ToastDecoration.fromToastType(ToastType toastType) {
    switch (toastType) {
      case ToastType.success:
        return ToastDecoration(
          backgroundColor: DesignColors.darkGreen_20,
          titleColor: DesignColors.green_100,
          iconColor: DesignColors.green_100,
          actionButtonBorderColor: DesignColors.white_50,
        );
      case ToastType.error:
        return ToastDecoration(
          backgroundColor: DesignColors.red_20,
          titleColor: DesignColors.red_100,
          iconColor: DesignColors.red_100,
          actionButtonBorderColor: DesignColors.gray2_100,
        );
      case ToastType.warning:
        return ToastDecoration(
          backgroundColor: DesignColors.yellow_20,
          titleColor: DesignColors.yellow_100,
          iconColor: DesignColors.yellow_100,
          actionButtonBorderColor: DesignColors.gray2_100,
        );
      default:
        return ToastDecoration(
          backgroundColor: DesignColors.purple_20,
          titleColor: DesignColors.white_100,
          iconColor: DesignColors.white_100,
          actionButtonBorderColor: DesignColors.gray2_100,
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
