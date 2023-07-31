import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';

class IdentityRegistrarLoadingState extends AIdentityRegistrarState {
  const IdentityRegistrarLoadingState({
    IRModel? irModel,
  }) : super(irModel: irModel);

  @override
  List<Object?> get props => <Object?>[runtimeType, irModel];
}
