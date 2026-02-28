import 'dart:typed_data';

import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

class MsgUndefined extends ATxMsg {
  final String? fromAddress;
  final String? toAddress;

  const MsgUndefined({
    required this.fromAddress,
    required this.toAddress,
  }) : super(typeUrl: '');

  factory MsgUndefined.fromData(Map<String, dynamic> data) {
    return MsgUndefined(
      fromAddress: data['proposer'] as String?,
      toAddress: data['address'] as String?,
    );
  }

  @override
  Map<String, dynamic> toProtoJson() => <String, dynamic>{};

  @override
  Uint8List toProtoBytes() => Uint8List(0);

  @override
  List<Object?> get props => <Object?>[];
}
