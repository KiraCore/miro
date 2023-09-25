import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_delete_records_form_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/views/pages/transactions/tx_send/ir_tx_delete_record_page/ir_tx_delete_record_confirm_dialog.dart';
import 'package:miro/views/widgets/transactions/send/tx_process_wrapper.dart';

class IRTxDeleteRecordPage extends StatefulWidget {
  final IRRecordModel irRecordModel;

  const IRTxDeleteRecordPage({
    required this.irRecordModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IRTxDeleteRecordPage();
}

class _IRTxDeleteRecordPage extends State<IRTxDeleteRecordPage> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  late final TxProcessCubit<IRMsgDeleteRecordsFormModel> txProcessCubit = TxProcessCubit<IRMsgDeleteRecordsFormModel>(
    txMsgType: TxMsgType.msgRegisterIdentityRecords,
    msgFormModel: IRMsgDeleteRecordsFormModel(
      irRecordModels: <IRRecordModel>[widget.irRecordModel],
      walletAddress: authCubit.state?.address,
    ),
  );

  @override
  void dispose() {
    txProcessCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxProcessWrapper<IRMsgDeleteRecordsFormModel>(
      formEnabledBool: false,
      txProcessCubit: txProcessCubit,
      txFormWidgetBuilder: null,
      txFormPreviewWidgetBuilder: (TxProcessConfirmState txProcessConfirmState) {
        return IRTxDeleteRecordConfirmDialog(
          txLocalInfoModel: txProcessConfirmState.signedTxModel.txLocalInfoModel,
          irMsgDeleteRecordsFormModel: txProcessCubit.msgFormModel,
        );
      },
    );
  }
}
