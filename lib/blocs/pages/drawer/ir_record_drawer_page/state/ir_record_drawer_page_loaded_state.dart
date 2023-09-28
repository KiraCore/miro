import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/a_ir_record_drawer_page_state.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_verification_request_model.dart';

class IRRecordDrawerPageLoadedState extends AIRRecordDrawerPageState {
  final List<IRRecordVerificationRequestModel> irRecordVerificationRequestModels;

  const IRRecordDrawerPageLoadedState({
    required this.irRecordVerificationRequestModels,
  });

  @override
  List<Object?> get props => <Object?>[irRecordVerificationRequestModels];
}
