import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/i_tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/register/identity_info_entry.dart';

class MsgRegisterIdentityRecords implements ITxMsg {
  final String address;
  final List<IdentityInfoEntry> infos;

  MsgRegisterIdentityRecords({
    required this.address,
    required this.infos,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '@type': '/kira.gov.MsgRegisterIdentityRecords',
      'address': address,
      'infos': infos.map((IdentityInfoEntry identityInfoEntry) => identityInfoEntry.toJson()).toList(),
    };
  }

  @override
  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      'type': 'kiraHub/MsgRegisterIdentityRecords',
      'value': <String, dynamic>{
        'address': address,
        'infos': infos.map((IdentityInfoEntry identityInfoEntry) => identityInfoEntry.toJson()).toList(),
      },
    };
  }
}
