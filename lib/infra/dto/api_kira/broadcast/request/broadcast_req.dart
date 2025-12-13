import 'dart:convert';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:equatable/equatable.dart';

class BroadcastReq extends Equatable {
  final CosmosTx tx;
  final String mode;

  const BroadcastReq({
    required this.tx,
    this.mode = 'sync',
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'tx': base64Encode(tx.toProtoBytes()),
      'mode': mode,
    };
  }

  @override
  List<Object?> get props => <Object?>[tx, mode];
}
