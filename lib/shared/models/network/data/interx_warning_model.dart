import 'package:equatable/equatable.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/data/block_time_model.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';

class InterxWarningModel extends Equatable {
  final List<InterxWarningType> interxWarningTypes;

  const InterxWarningModel(this.interxWarningTypes);

  factory InterxWarningModel.selectWarningType(NetworkInfoModel networkInfoModel, TokenDefaultDenomModel? tokenDefaultDenomModel) {
    AppConfig appConfig = globalLocator<AppConfig>();
    bool missingTokenDefaultDenomModelBool = tokenDefaultDenomModel == null;
    bool versionOutdatedBool = appConfig.isInterxVersionOutdated(networkInfoModel.interxVersion);
    bool blockTimeOutdatedBool = BlockTimeModel(networkInfoModel.latestBlockTime).isOutdated();

    List<InterxWarningType> interxWarningTypes = <InterxWarningType>[
      if (missingTokenDefaultDenomModelBool) InterxWarningType.missingDefaultTokenDenomModel,
      if (versionOutdatedBool) InterxWarningType.versionOutdated,
      if (blockTimeOutdatedBool) InterxWarningType.blockTimeOutdated
    ];

    return InterxWarningModel(interxWarningTypes);
  }

  bool get hasErrors => interxWarningTypes.isNotEmpty;

  @override
  List<Object?> get props => <Object>[interxWarningTypes];
}
