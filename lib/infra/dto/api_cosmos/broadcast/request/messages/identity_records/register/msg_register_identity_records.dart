import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/a_tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/register/identity_info_entry.dart';

class MsgRegisterIdentityRecords extends ATxMsg {
  final String address;
  final List<IdentityInfoEntry> infos;

  const MsgRegisterIdentityRecords({
    required this.address,
    required this.infos,
  }) : super(
          messageType: '/kira.gov.MsgRegisterIdentityRecords',
          signatureMessageType: 'kiraHub/MsgRegisterIdentityRecords',
        );

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
