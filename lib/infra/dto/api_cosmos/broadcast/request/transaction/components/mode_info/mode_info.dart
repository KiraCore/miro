// TODO(dominik): There can be Multi option (https://docs.cosmos.network/v0.44/core/proto-docs.html#cosmos.tx.v1beta1.ModeInfo)
import 'dart:convert';

import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/mode_info/single_mode_info.dart';

/// ModeInfo describes the signing mode of a single or nested multisign signer.
class ModeInfo {
  /// Single is the mode info for a single signer. It is structured as a message
  /// to allow for additional fields such as locale for SIGN_MODE_TEXTUAL in the future
  final SingleModeInfo single;

  const ModeInfo({
    required this.single,
  });

  factory ModeInfo.fromJson(Map<String, dynamic> json) {
    return ModeInfo(
      single: SingleModeInfo.fromJson(
        json['single'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'single': single.toJson()};
  }

  @override
  String toString() => jsonEncode(toJson());
}
