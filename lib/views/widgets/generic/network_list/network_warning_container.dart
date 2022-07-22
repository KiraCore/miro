import 'package:flutter/cupertino.dart';
import 'package:miro/shared/models/network/interx_error_type.dart';
import 'package:miro/views/widgets/kira/kira_toast/toast_container.dart';

class NetworkWarningContainer extends StatelessWidget {
  final InterxErrorType interxErrorType;
  final String latestBlockTime;

  const NetworkWarningContainer({
    required this.interxErrorType,
    required this.latestBlockTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<InterxErrorType, String> interxErrorMessages = <InterxErrorType, String>{
      InterxErrorType.blockTimeOutdated:
          'The last available block on this interx was created long time ago ($latestBlockTime). The displayed data may be out of date',
      InterxErrorType.versionOutdated: 'Interx is not updated to the latest version. Some views may not work correctly',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ToastContainer(
        width: double.infinity,
        title: Text(
          interxErrorMessages[interxErrorType] ?? 'Undefined error',
          style: const TextStyle(fontSize: 11),
        ),
        toastType: ToastType.warning,
      ),
    );
  }
}
