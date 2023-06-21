import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests_by_requester/response/verify_record.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class IRVerificationRequestModel extends Equatable {
  final WalletAddress requesterWalletAddress;
  final WalletAddress verifierWalletAddress;
  final List<String> recordIds;

  const IRVerificationRequestModel({
    required this.requesterWalletAddress,
    required this.verifierWalletAddress,
    required this.recordIds,
  });

  factory IRVerificationRequestModel.fromDto(VerifyRecord verifyRecord) {
    return IRVerificationRequestModel(
      requesterWalletAddress: WalletAddress.fromBech32(verifyRecord.address),
      verifierWalletAddress: WalletAddress.fromBech32(verifyRecord.verifier),
      recordIds: verifyRecord.recordIds,
    );
  }

  @override
  List<Object?> get props => <Object>[requesterWalletAddress, verifierWalletAddress, recordIds];
}
