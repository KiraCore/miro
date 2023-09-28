import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';

class IRRecordVerificationRequestModel extends Equatable {
  final IRUserProfileModel verifierIrUserProfileModel;
  final IRVerificationRequestStatus irVerificationRequestStatus;

  const IRRecordVerificationRequestModel({
    required this.verifierIrUserProfileModel,
    required this.irVerificationRequestStatus,
  });

  @override
  List<Object?> get props => <Object?>[verifierIrUserProfileModel, irVerificationRequestStatus];
}
