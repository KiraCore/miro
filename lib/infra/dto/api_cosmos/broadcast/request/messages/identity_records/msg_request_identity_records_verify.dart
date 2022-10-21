import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/i_tx_msg.dart';

/// MsgRequestIdentityRecordsVerify defines a proposal message
/// to request an identity record verification from a specific verifier
class MsgRequestIdentityRecordsVerify implements ITxMsg {
  /// The address of requester
  final String address;

  /// The id of records to be verified
  final List<BigInt> recordIds;

  /// The amount of coins to be given up-on accepting the request
  final Coin tip;

  /// The address of verifier
  final String verifier;

  MsgRequestIdentityRecordsVerify({
    required this.address,
    required this.recordIds,
    required this.tip,
    required this.verifier,
  });

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '@type': '/kira.gov.MsgRequestIdentityRecordsVerify',
      'address': address,
      'record_ids': recordIds.map((BigInt recordId) => recordId.toString()).toList(),
      'tip': tip.toJson(),
      'verifier': verifier,
    };
  }

  @override
  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      'type': 'kiraHub/MsgRequestIdentityRecordsVerify',
      'value': <String, dynamic>{
        'address': address,
        'record_ids': recordIds.map((BigInt recordId) => recordId.toString()).toList(),
        'tip': tip.toJson(),
        'verifier': verifier,
      },
    };
  }
}
