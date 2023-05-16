import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:miro/config/app_icons.dart';
import 'package:miro/config/theme/design_colors.dart';
import 'package:miro/views/widgets/generic/mouse_state_listener.dart';
import 'package:miro/views/widgets/kira/kira_toast/kira_toast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_type.dart';

class CopyButton extends StatelessWidget {
  final String value;
  final String? notificationText;

  const CopyButton({
    required this.value,
    this.notificationText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseStateListener(
      onTap: () => _copy(context),
      disableSplash: true,
      childBuilder: (Set<MaterialState> states) {
        Color color = DesignColors.white2;
        if (states.contains(MaterialState.hovered)) {
          color = DesignColors.white1;
        }
        return Icon(
          AppIcons.copy,
          color: color,
          size: 15,
        );
      },
    );
  }

  void _copy(BuildContext context) {
    Clipboard.setData(ClipboardData(text: value));
    if (notificationText != null) {
      KiraToast.of(context).show(
        type: ToastType.success,
        message: notificationText!,
      );
    }
  }
}
