import 'package:flutter/material.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

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
      InterxWarningType.blockTimeOutdated:
          'The last available block on this interx was created long time ago ($latestBlockTime). The displayed data may be out of date',
      InterxWarningType.versionOutdated: 'The application is incompatible with this server. Some views may not work correctly',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ToastContainer(
        width: double.infinity,
        title: Text(
          interxWarningMessages[interxWarningType] ?? 'Undefined error',
          style: textTheme.caption!,
        ),
        toastType: ToastType.warning,
      ),
    );
  }
}
