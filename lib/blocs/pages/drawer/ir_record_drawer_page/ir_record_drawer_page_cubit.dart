import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/a_ir_record_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/state/ir_record_drawer_page_error_state.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/state/ir_record_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/ir_record_drawer_page/state/ir_record_drawer_page_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/identity_records_service.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_model.dart';

class IRRecordDrawerPageCubit extends Cubit<AIRRecordDrawerPageState> {
  final IdentityRecordsService _identityRecordsService = globalLocator<IdentityRecordsService>();

  final IRRecordModel irRecordModel;

  IRRecordDrawerPageCubit({
    required this.irRecordModel,
  }) : super(const IRRecordDrawerPageLoadingState());

  Future<void> init() async {
    try {
      emit(const IRRecordDrawerPageLoadingState());
      List<IRVerificationModel> identityRecordVerificationModels = await _identityRecordsService.getRecordVerifications(irRecordModel);
      emit(IRRecordDrawerPageLoadedState(irVerificationModels: identityRecordVerificationModels));
    } catch (e) {
      emit(IRRecordDrawerPageErrorState());
    }
  }
}
