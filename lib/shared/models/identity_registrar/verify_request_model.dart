import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/response/verify_record.dart';

class VerifyRequestModel {
  final String verifier;

  VerifyRequestModel({
    required this.verifier,
  });

  factory VerifyRequestModel.fromDto(VerifyRecord verifyRecord) {
    return VerifyRequestModel(
      verifier: verifyRecord.verifier,
    );
  }
}
