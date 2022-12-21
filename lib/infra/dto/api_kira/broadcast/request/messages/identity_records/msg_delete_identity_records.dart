import 'package:miro/infra/dto/api_kira/broadcast/request/messages/a_tx_msg.dart';

/// MsgDeleteIdentityRecords defines a method to delete identity records owned by an address
class MsgDeleteIdentityRecords extends ATxMsg {
  /// The address for the identity record
  final String address;

  /// The array string that defines identity record key values to be deleted
  final List<String> keys;

  const MsgDeleteIdentityRecords({
    required this.address,
    required this.keys,
  }) : super(
          messageType: '/kira.gov.MsgDeleteIdentityRecords',
          signatureMessageType: 'kiraHub/MsgDeleteIdentityRecords',
        );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': address,
      'keys': keys,
    };
  }

  @override
  List<Object?> get props => <Object?>[address, keys];
}
