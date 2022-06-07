import 'package:flutter/cupertino.dart';
import 'package:miro/shared/models/network/status/online/interx_error.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

class NetworkWarningContainer extends StatelessWidget {
  final InterxError interxError;
  final String latestBlockTime;

  const NetworkWarningContainer({
    required this.interxError,
    required this.latestBlockTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<InterxError, String> interxErrorMessages = <InterxError, String>{
      InterxError.blockTimeOutdated:
          'The last available block on this interx was created long time ago ($latestBlockTime). The displayed data may be out of date',
      InterxError.versionOutdated: 'Interx is not updated to the latest version. Some views may not work correctly',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ToastContainer(
        width: double.infinity,
        title: Text(
          interxErrorMessages[interxError] ?? 'Undefined error',
          style: const TextStyle(fontSize: 11),
        ),
        toastType: ToastType.warning,
      ),
    );
  }
}
