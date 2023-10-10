import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_type.dart';

class NetworkWarningContainer extends StatelessWidget {
  final InterxWarningType interxWarningType;
  final String latestBlockTime;

  const NetworkWarningContainer({
    required this.interxWarningType,
    required this.latestBlockTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Map<InterxWarningType, String> interxWarningMessages = <InterxWarningType, String>{
      InterxWarningType.blockTimeOutdated: S.of(context).networkWarningWhenLastBlock(latestBlockTime),
      InterxWarningType.versionOutdated: S.of(context).networkWarningIncompatible,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ToastContainer(
        width: double.infinity,
        title: Text(
          interxWarningMessages[interxWarningType] ?? S.of(context).errorUndefined,
          style: textTheme.bodySmall!,
        ),
        toastType: ToastType.warning,
      ),
    );
  }
}
