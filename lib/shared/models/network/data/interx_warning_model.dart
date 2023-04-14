import 'package:equatable/equatable.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/data/block_time_model.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';

class InterxWarningModel extends Equatable {
  final List<InterxWarningType> interxWarningTypes;

  const InterxWarningModel(this.interxWarningTypes);

  factory InterxWarningModel.fromNetworkInfoModel(NetworkInfoModel networkInfoModel) {
    AppConfig appConfig = globalLocator<AppConfig>();
    bool versionOutdated = appConfig.isInterxVersionOutdated(networkInfoModel.interxVersion);
    bool blockTimeOutdated = BlockTimeModel(networkInfoModel.latestBlockTime).isOutdated();

    List<InterxWarningType> interxWarningTypes = <InterxWarningType>[
      if (versionOutdated) InterxWarningType.versionOutdated,
      if (blockTimeOutdated) InterxWarningType.blockTimeOutdated
    ];

    return InterxWarningModel(interxWarningTypes);
  }

  bool get hasErrors => interxWarningTypes.isNotEmpty;

  @override
  List<Object?> get props => <Object>[interxWarningTypes];
}
