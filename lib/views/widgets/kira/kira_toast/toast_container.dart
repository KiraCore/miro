import 'package:flutter/material.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/views/widgets/buttons/kira_outlined_button.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_decoration.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_type.dart';

class ToastContainer extends StatelessWidget {
  final Text title;
  final ToastType toastType;
  final bool showDefaultIcon;
  final bool showBorder;
  final double height;
  final double? width;
  final String? actionTitle;
  final Icon? icon;
  final VoidCallback? onActionTap;
  final ToastDecoration? toastDecoration;

  const ToastContainer({
    required this.title,
    required this.toastType,
    this.showDefaultIcon = true,
    this.showBorder = false,
    this.height = 59,
    this.width,
    this.toastDecoration,
    this.icon,
    this.onActionTap,
    this.actionTitle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    Icon? toastIcon = _getIcon();
    ToastDecoration localToastDecoration = toastDecoration ?? ToastDecoration.fromToastType(toastType);
    return Container(
      width: width,
      constraints: BoxConstraints(minHeight: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: localToastDecoration.backgroundColor,
        border: showBorder == true ? Border.all(color: localToastDecoration.actionButtonBorderColor) : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: width == null ? MainAxisSize.min : MainAxisSize.max,
        children: <Widget>[
          if (toastIcon != null) ...<Widget>[
            Icon(
              toastIcon.icon,
              size: toastIcon.size ?? 20,
              color: toastIcon.color ?? localToastDecoration.iconColor,
            ),
            const SizedBox(width: 20),
          ],
          if (width != null)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  title.data ?? '',
                  style: textTheme.bodyText2!.copyWith(
                    color: localToastDecoration.titleColor,
                    fontSize: title.style?.fontSize ?? textTheme.bodyText2!.fontSize,
                  ),
                ),
              ),
            )
          else
            Text(
              title.data ?? '',
              style: textTheme.bodyText2!.copyWith(
                color: localToastDecoration.titleColor,
                fontSize: title.style?.fontSize ?? textTheme.bodyText2!.fontSize,
              ),
            ),
          if (actionTitle != null) ...<Widget>[
            const SizedBox(width: 20),
            KiraOutlinedButton(
              height: 39,
              width: 150,
              onPressed: onActionTap,
              title: actionTitle!,
              borderColor: localToastDecoration.actionButtonBorderColor,
            ),
          ],
        ],
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
