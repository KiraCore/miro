import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/coin.dart';

/// The identity record verify request info
class VerifyRecord extends Equatable {
  /// The request address of identity record
  final String address;

  /// The verify request id
  final String id;

  /// The latest edit date
  final DateTime lastRecordEditDate;

  /// The array of identity record id
  final List<String> recordIds;

  /// The tip amount for verification
  final Coin tip;

  /// The verifier address of identity record
  final String verifier;

  const VerifyRecord({
    required this.address,
    required this.id,
    required this.lastRecordEditDate,
    required this.recordIds,
    required this.tip,
    required this.verifier,
  });

  factory VerifyRecord.fromJson(Map<String, dynamic> json) {
    return VerifyRecord(
      address: json['address'] as String,
      id: json['id'] as String,
      lastRecordEditDate: DateTime.parse(json['lastRecordEditDate'] as String),
      recordIds: json['recordIds'] != null
          ? (json['recordIds'] as List<dynamic>).map((dynamic e) => e as String).toList()
          : List<String>.empty(),
      tip: Coin.fromJson(json['tip'] as Map<String, dynamic>),
      verifier: json['verifier'] as String,
    );
  }

  @override
  String toString() {
    return 'VerifyRecord{address: $address, id: $id, lastRecordEditDate: $lastRecordEditDate, recordIds: $recordIds, tip: $tip, verifier: $verifier}';
  }

  @override
  List<Object?> get props => <Object?>[address, id, lastRecordEditDate, recordIds, tip, verifier];
}
