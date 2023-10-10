import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_confirm_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/tx_process_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/transactions/form_models/ir_msg_handle_verification_request_form_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/views/pages/transactions/tx_send/ir_tx_handle_verification_request_page/ir_tx_handle_verification_request_confirm_dialog.dart';
import 'package:miro/views/widgets/transactions/send/tx_process_wrapper.dart';

@RoutePage()
class IRTxHandleVerificationRequestPage extends StatefulWidget {
  final bool approvalStatusBool;
  final IRInboundVerificationRequestModel irInboundVerificationRequestModel;

  const IRTxHandleVerificationRequestPage({
    required this.approvalStatusBool,
    required this.irInboundVerificationRequestModel,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _IRTxHandleVerificationRequestPage();
}

class _IRTxHandleVerificationRequestPage extends State<IRTxHandleVerificationRequestPage> {
  final AuthCubit authCubit = globalLocator<AuthCubit>();
  late final TxProcessCubit<IRMsgHandleVerificationRequestFormModel> txProcessCubit = TxProcessCubit<IRMsgHandleVerificationRequestFormModel>(
    txMsgType: TxMsgType.msgRegisterIdentityRecords,
    msgFormModel: IRMsgHandleVerificationRequestFormModel(
      approvalStatusBool: widget.approvalStatusBool,
      walletAddress: authCubit.state?.address,
      irInboundVerificationRequestModel: widget.irInboundVerificationRequestModel,
    ),
  );

  @override
  void dispose() {
    txProcessCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TxProcessWrapper<IRMsgHandleVerificationRequestFormModel>(
      formEnabledBool: false,
      txProcessCubit: txProcessCubit,
      txFormWidgetBuilder: null,
      txFormPreviewWidgetBuilder: (TxProcessConfirmState txProcessConfirmState) {
        return IRTxHandleVerificationRequestConfirmDialog(
          approvalStatusBool: widget.approvalStatusBool,
          txLocalInfoModel: txProcessConfirmState.signedTxModel.txLocalInfoModel,
          irMsgHandleVerificationRequestFormModel: txProcessCubit.msgFormModel,
        );
      },
    );
  }
}
