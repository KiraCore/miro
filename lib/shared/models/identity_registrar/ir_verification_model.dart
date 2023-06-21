import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';

class IRVerificationModel extends Equatable {
  final IRModel verifierIrModel;
  final IRVerificationRequestStatus irVerificationRequestStatus;

  const IRVerificationModel({
    required this.verifierIrModel,
    required this.irVerificationRequestStatus,
  });

  @override
  List<Object?> get props => <Object?>[verifierIrModel, irVerificationRequestStatus];
}
