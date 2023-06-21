import 'package:equatable/equatable.dart';

class VerifyRecord extends Equatable {
  final String address;
  final String id;
  final DateTime lastRecordEditDate;
  final List<String> recordIds;
  final String tip;
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
      recordIds: json['recordIds'] != null ? (json['recordIds'] as List<dynamic>).map((dynamic e) => e as String).toList() : List<String>.empty(),
      tip: json['tip'] as String,
      verifier: json['verifier'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[address, id, lastRecordEditDate, recordIds, tip, verifier];
}
