import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/a_ir_record_drawer_page_state.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_model.dart';

class IRRecordDrawerPageLoadedState extends AIRRecordDrawerPageState {
  final List<IRVerificationModel> irVerificationModels;

  const IRRecordDrawerPageLoadedState({
    required this.irVerificationModels,
  });

  @override
  List<Object?> get props => <Object?>[irVerificationModels];
}
