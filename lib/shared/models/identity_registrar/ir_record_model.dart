import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_records/response/record.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_status.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/string_utils.dart';

class IRRecordModel extends Equatable {
  final String key;
  final String? value;
  final List<WalletAddress> verifiersAddresses;
  final List<IRVerificationRequestModel> irVerificationRequests;

  const IRRecordModel({
    required this.key,
    required this.value,
    required this.verifiersAddresses,
    required this.irVerificationRequests,
  });

  const IRRecordModel.empty({
    required this.key,
  })  : value = null,
        verifiersAddresses = const <WalletAddress>[],
        irVerificationRequests = const <IRVerificationRequestModel>[];

  factory IRRecordModel.fromDto(Record record, List<IRVerificationRequestModel> irVerificationRequests) {
    return IRRecordModel(
      key: record.key,
      value: StringUtils.parseUnicodeToString(record.value),
      verifiersAddresses: record.verifiers.map(WalletAddress.fromBech32).toList(),
      irVerificationRequests: irVerificationRequests,
    );
  }

  IRRecordStatus get irRecordStatus => IRRecordStatus.build(
        hasVerifiersBool: verifiersAddresses.isNotEmpty,
        hasPendingVerifiersBool: irVerificationRequests.isNotEmpty,
      );

  @override
  List<Object?> get props => <Object?>[key, value, verifiersAddresses, irVerificationRequests];
}
