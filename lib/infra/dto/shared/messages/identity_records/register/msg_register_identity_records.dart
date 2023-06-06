import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/register/identity_info_entry.dart';

/// Message to create or edit an identity record
/// Represents MsgRegisterIdentityRecords interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
class MsgRegisterIdentityRecords extends ATxMsg {
  /// The address for the identity record
  final String address;

  /// The array of identity record info
  final List<IdentityInfoEntry> infos;

  const MsgRegisterIdentityRecords({
    required this.address,
    required this.infos,
  }) : super(
          messageType: '/kira.gov.MsgRegisterIdentityRecords',
          signatureMessageType: 'kiraHub/MsgRegisterIdentityRecords',
        );

  factory MsgRegisterIdentityRecords.fromJson(Map<String, dynamic> json) {
    return MsgRegisterIdentityRecords(
      address: json['address'] as String,
      infos: (json['infos'] as List<dynamic>).map((dynamic e) => IdentityInfoEntry.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': address,
      'infos': infos.map((IdentityInfoEntry identityInfoEntry) => identityInfoEntry.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => <Object?>[address, infos];
}
