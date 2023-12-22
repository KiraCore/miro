import 'package:miro/blocs/generic/identity_registrar/a_identity_registrar_state.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';

class IdentityRegistrarLoadingState extends AIdentityRegistrarState {
  const IdentityRegistrarLoadingState({
    DateTime? blockDateTime,
    IRModel? irModel,
  }) : super(blockDateTime: blockDateTime, irModel: irModel);

  @override
  List<Object?> get props => <Object?>[runtimeType, blockDateTime, irModel];
}
