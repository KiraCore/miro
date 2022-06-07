import 'package:flutter/cupertino.dart';
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
    Map<InterxWarningType, String> interxWarningMessages = <InterxWarningType, String>{
      InterxWarningType.blockTimeOutdated:
          'The last available block on this interx was created long time ago ($latestBlockTime). The displayed data may be out of date',
      InterxWarningType.versionOutdated: 'Interx is not updated to the latest version. Some views may not work correctly',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ToastContainer(
        width: double.infinity,
        title: Text(
          interxWarningMessages[interxWarningType] ?? 'Undefined error',
          style: const TextStyle(fontSize: 11),
        ),
        toastType: ToastType.warning,
      ),
    );
  }
}
