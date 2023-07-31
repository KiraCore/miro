import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';

abstract class AIdentityRegistrarState extends Equatable {
  final IRModel? irModel;

  const AIdentityRegistrarState({this.irModel});
}
