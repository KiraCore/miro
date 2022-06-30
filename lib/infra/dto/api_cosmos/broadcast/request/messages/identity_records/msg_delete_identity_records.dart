import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';

/// MsgDeleteIdentityRecords defines a method to delete identity records owned by an address
class MsgDeleteIdentityRecords extends TxMsg {
  /// The address for the identity record
  final String address;

  /// The array string that defines identity record key values to be deleted
  final List<String> keys;

  MsgDeleteIdentityRecords({
    required this.address,
    required this.keys,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '@type': '/kira.gov.MsgDeleteIdentityRecords',
      'address': address,
      'keys': keys,
    };
  }

  @override
  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      // TODO(dominik): Update type to 'kiraHub/MsgDeleteIdentityRecords' after new testnet release
      'type': 'kiraHub/MsgEditIdentityRecord',
      'value': <String, dynamic>{
        'address': address,
        'keys': keys,
      },
    };
  }
}
