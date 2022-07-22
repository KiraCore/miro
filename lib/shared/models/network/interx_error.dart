import 'package:miro/config/app_config.dart';
import 'package:miro/shared/models/network/block_time_model.dart';
import 'package:miro/shared/models/network/interx_error_type.dart';
import 'package:miro/shared/models/network/network_info_model.dart';

class InterxError {
  final List<InterxErrorType> interxErrorTypes;

  InterxError(this.interxErrorTypes);

  factory InterxError.fromNetworkInfoModel(NetworkInfoModel networkInfoModel) {
    bool versionOutdated = !AppConfig.isInterxVersionSupported(networkInfoModel.interxVersion);
    bool blockTimeOutdated = BlockTimeModel(networkInfoModel.latestBlockTime).isOutdated();

    List<InterxErrorType> interxErrorTypes = <InterxErrorType>[
      if (versionOutdated) InterxErrorType.versionOutdated,
      if (blockTimeOutdated) InterxErrorType.blockTimeOutdated
    ];

    return InterxError(interxErrorTypes);
  }

  bool get hasErrors => interxErrorTypes.isNotEmpty;
}
