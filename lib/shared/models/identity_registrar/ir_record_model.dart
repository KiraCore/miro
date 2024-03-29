import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/record.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_status.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/string_utils.dart';

class IRRecordModel extends Equatable {
  final String id;
  final String key;
  final String? value;
  final List<WalletAddress> verifiersAddresses;
  final List<WalletAddress> pendingVerifiersAddresses;
  final DateTime? dateTime;

  const IRRecordModel({
    required this.id,
    required this.key,
    required this.value,
    required this.verifiersAddresses,
    required this.pendingVerifiersAddresses,
    this.dateTime,
  });

  const IRRecordModel.empty({
    required this.key,
  })  : id = '0',
        value = null,
        verifiersAddresses = const <WalletAddress>[],
        pendingVerifiersAddresses = const <WalletAddress>[],
        dateTime = null;

  factory IRRecordModel.fromDto(Record record, List<WalletAddress> pendingVerifiersAddresses) {
    return IRRecordModel(
      id: record.id,
      key: record.key,
      value: StringUtils.parseUnicodeToString(record.value),
      verifiersAddresses: record.verifiers.map(WalletAddress.fromBech32).toList(),
      pendingVerifiersAddresses: pendingVerifiersAddresses,
      dateTime: record.date,
    );
  }

  bool isEmpty() {
    return value == null || value!.isEmpty;
  }

  IRRecordStatus get irRecordStatus => IRRecordStatus.build(
        hasVerifiersBool: verifiersAddresses.isNotEmpty,
        hasPendingVerifiersBool: pendingVerifiersAddresses.isNotEmpty,
      );

  @override
  List<Object?> get props => <Object?>[key, value, verifiersAddresses, pendingVerifiersAddresses];
}
