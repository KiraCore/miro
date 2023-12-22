import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';

class IdentityRegistrarLoadedState extends AIdentityRegistrarState {
  const IdentityRegistrarLoadedState({
    required IRModel irModel,
    DateTime? blockDateTime,
  }) : super(irModel: irModel, blockDateTime: blockDateTime);

  @override
  List<Object?> get props => <Object?>[runtimeType, irModel, blockDateTime];
}
