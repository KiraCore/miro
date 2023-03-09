import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

class KiraToast {
  final BuildContext context;

  KiraToast.of(this.context);

  Future<void> show({
    required String message,
    required ToastType type,
    VoidCallback? onActionTap,
    String? actionTitle,
    Icon? icon,
    bool showDefaultIcon = true,
    Duration toastDuration = const Duration(seconds: 1),
  }) async {
    FToast()
      // Remove actual displayed toast if exists
      ..removeCustomToast()
      ..removeQueuedCustomToasts()
      // Show new toast
      ..init(context)
      ..showToast(
        toastDuration: toastDuration,
        child: ToastContainer(
          title: Text(message),
          toastType: type,
          onActionTap: onActionTap,
          actionTitle: actionTitle,
          icon: icon,
          showDefaultIcon: showDefaultIcon,
          showBorder: true,
        ),
      );
  }
}
