import 'dart:typed_data';

import 'package:codec_utils/codec_utils.dart';
import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/register/identity_info_entry.dart';

/// Message to create or edit an identity record
/// Represents MsgRegisterIdentityRecords interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
class MsgRegisterIdentityRecords extends ATxMsg {
  /// The address for the identity record
  final CosmosAccAddress address;

  /// The array of identity record info
  final List<IdentityInfoEntry> infos;

  MsgRegisterIdentityRecords({
    required this.address,
    required this.infos,
  }) : super(typeUrl: '/kira.gov.MsgRegisterIdentityRecords');

  factory MsgRegisterIdentityRecords.fromData(Map<String, dynamic> data) {
    return MsgRegisterIdentityRecords(
      address: CosmosAccAddress(data['address'] as String),
      infos: (data['infos'] as List<dynamic>).map((dynamic e) => IdentityInfoEntry.fromData(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Uint8List toProtoBytes() {
    return ProtobufEncoder.encode(<int, AProtobufField>{
      1: address,
      2: ProtobufList(infos),
    });
  }

  @override
  Map<String, dynamic> toProtoJson() {
    return <String, dynamic>{
      '@type': typeUrl,
      'address': address.value,
      'infos': infos.map((IdentityInfoEntry identityInfoEntry) => identityInfoEntry.toProtoJson()).toList(),
    };
  }

  @override
  List<Object?> get props => <Object?>[address, infos];
}
