import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/transaction/components/mode_info/sign_mode.dart';
import 'package:miro/shared/utils/enum_utils.dart';

class SingleModeInfo extends Equatable {
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

  @override
  List<Object?> get props => <Object?>[mode];
}
