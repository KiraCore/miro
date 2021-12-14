import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/identity_info_entry.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';

class MsgRegisterIdentityRecords extends TxMsg {
  final String address;
  final List<IdentityInfoEntry> records;

  MsgRegisterIdentityRecords({
    required this.address,
    required this.records,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '@type': '/kira.gov.MsgRegisterIdentityRecords',
      'address': address,
      'infos': records.map((IdentityInfoEntry e) => e.toJson()).toList(),
    };
  }

  @override
  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      'type': 'kiraHub/MsgRegisterIdentityRecords',
      'value': <String, dynamic>{
        'address': address,
        'infos': records.map((IdentityInfoEntry e) => e.toJson()).toList(),
      },
    };
  }
}
