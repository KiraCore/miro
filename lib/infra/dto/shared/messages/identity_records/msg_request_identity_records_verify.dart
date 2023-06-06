import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

/// Proposal message to request an identity record verification from a specific verifier
/// Represents MsgRequestIdentityRecordsVerify interface from Kira SDK:
/// https://github.com/KiraCore/sekai/blob/master/proto/kira/gov/identity_registrar.proto
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

  factory MsgRequestIdentityRecordsVerify.fromJson(Map<String, dynamic> json) {
    return MsgRequestIdentityRecordsVerify(
      address: json['address'] as String,
      recordIds: (json['record_ids'] as List<dynamic>).map((dynamic e) => BigInt.from(e as num)).toList(),
      tip: Coin.fromJson(json['tip'] as Map<String, dynamic>),
      verifier: json['verifier'] as String,
    );
  }

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
