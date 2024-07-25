import 'dart:typed_data';

import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

class MsgUndelegate extends ATxMsg {
  final String delegatorAddress;
  final String valoperAddress;
  final List<CosmosCoin> amounts;

  MsgUndelegate({
    required this.delegatorAddress,
    required this.valoperAddress,
    required this.amounts,
  }) : super(typeUrl: '/kira.multistaking.MsgUndelegate');

  factory MsgUndelegate.fromData(Map<String, dynamic> data) {
    return MsgUndelegate(
      delegatorAddress: data['delegator_address'] as String,
      valoperAddress: data['validator_address'] as String,
      amounts: (data['amounts'] as List<dynamic>).map((dynamic e) => CosmosCoin.fromProtoJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return Uint8List.fromList(<int>[
      ...ProtobufEncoder.encode(1, delegatorAddress),
      ...ProtobufEncoder.encode(2, valoperAddress),
      ...ProtobufEncoder.encode(3, amounts),
    ]);
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'delegator_address': delegatorAddress,
      'validator_address': valoperAddress,
      'amounts': amounts.map((CosmosCoin cosmosCoin) => cosmosCoin.toProtoJson()).toList(),
    };
  }

  @override
  List<Object?> get props => <Object>[delegatorAddress, valoperAddress, amounts];
}
