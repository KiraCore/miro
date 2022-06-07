import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_decoration.dart';

enum ToastType {
  normal,
  error,
  success,
  warning,
}

class ToastContainer extends StatelessWidget {
  final double height;
  final double? width;
  final VoidCallback? onActionTap;
  final String? actionTitle;
  final Text title;
  final Icon? icon;
  final ToastType toastType;
  final bool showDefaultIcon;
  final ToastDecoration? toastDecoration;

  const ToastContainer({
    required this.title,
    required this.toastType,
    this.height = 59,
    this.width,
    this.toastDecoration,
    this.icon,
    this.onActionTap,
    this.actionTitle,
    this.showDefaultIcon = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Icon? _toastIcon = _getIcon();
    ToastDecoration _toastDecoration = toastDecoration ?? ToastDecoration.fromToastType(toastType);
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: width,
        constraints: BoxConstraints(minHeight: height),
        color: DesignColors.gray1_100,
        child: Container(
          width: width,
          constraints: BoxConstraints(minHeight: height),
          color: _toastDecoration.backgroundColor,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
            children: <Widget>[
              if (_toastIcon != null) ...<Widget>[
                Icon(
                  _toastIcon.icon,
                  size: _toastIcon.size ?? 20,
                  color: _toastIcon.color ?? _toastDecoration.iconColor,
                ),
                const SizedBox(width: 20),
              ],
              if (width != null)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      title.data ?? '',
                      style: (title.style ?? const TextStyle()).copyWith(
                        color: title.style?.color ?? _toastDecoration.titleColor,
                        fontSize: title.style?.fontSize ?? 14,
                      ),
                    ),
                  ),
                )
              else
                Text(
                  title.data ?? '',
                  style: (title.style ?? const TextStyle()).copyWith(
                    color: title.style?.color ?? _toastDecoration.titleColor,
                    fontSize: title.style?.fontSize ?? 14,
                  ),
                ),
              if (actionTitle != null) ...<Widget>[
                const SizedBox(width: 20),
                KiraOutlinedButton(
                  height: 39,
                  width: 150,
                  onPressed: onActionTap,
                  title: actionTitle!,
                  borderColor: _toastDecoration.actionButtonBorderColor,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Icon? _getIcon() {
    Icon? toastIcon = icon;
    if (toastIcon == null && showDefaultIcon) {
      toastIcon = _getDefaultIcon();
    }
    return toastIcon;
  }

  Icon? _getDefaultIcon() {
    switch (toastType) {
      case ToastType.error:
        return const Icon(AppIcons.error);
      case ToastType.warning:
        return const Icon(AppIcons.alert_circle);
      case ToastType.success:
        return const Icon(AppIcons.checkbox_circle);
      default:
        return null;
    }
  }
}
