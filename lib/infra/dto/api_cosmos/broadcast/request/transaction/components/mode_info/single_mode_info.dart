import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/sign_mode.dart';
import 'package:miro/shared/utils/enum_utils.dart';

class SingleModeInfo {
  final SignMode mode;

  const SingleModeInfo({
    required this.mode,
  });

  factory SingleModeInfo.fromJson(Map<String, dynamic> json) {
    return SingleModeInfo(
      mode: EnumUtils.parseFromString(
        SignMode.values,
        json['mode'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'mode': EnumUtils.parseToString(mode),
      };
}
