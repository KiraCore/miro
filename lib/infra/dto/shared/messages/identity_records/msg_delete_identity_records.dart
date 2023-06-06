import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

/// Message to delete identity records owned by an address
/// Represents MsgDeleteIdentityRecords interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
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

  factory MsgDeleteIdentityRecords.fromJson(Map<String, dynamic> json) {
    return MsgDeleteIdentityRecords(
      address: json['address'] as String,
      keys: (json['keys'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

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
