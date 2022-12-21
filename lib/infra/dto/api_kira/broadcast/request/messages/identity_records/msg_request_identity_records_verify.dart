import 'package:miro/infra/dto/api_kira/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_kira/broadcast/request/messages/a_tx_msg.dart';

/// MsgRequestIdentityRecordsVerify defines a proposal message
/// to request an identity record verification from a specific verifier
class MsgRequestIdentityRecordsVerify extends ATxMsg {
  /// The address of requester
  final String address;

  /// The id of records to be verified
  final List<BigInt> recordIds;

  /// The amount of coins to be given up-on accepting the request
  final Coin tip;

  /// The address of verifier
  final String verifier;

  const MsgRequestIdentityRecordsVerify({
    required this.address,
    required this.recordIds,
    required this.tip,
    required this.verifier,
  }) : super(
          messageType: '/kira.gov.MsgRequestIdentityRecordsVerify',
          signatureMessageType: 'kiraHub/MsgRequestIdentityRecordsVerify',
        );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': address,
      'record_ids': recordIds.map((BigInt recordId) => recordId.toString()).toList(),
      'tip': tip.toJson(),
      'verifier': verifier,
    };
  }

  @override
  List<Object?> get props => <Object?>[address, recordIds, tip, verifier];
}
