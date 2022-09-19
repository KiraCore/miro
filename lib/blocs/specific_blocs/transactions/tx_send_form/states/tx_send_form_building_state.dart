import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_loaded_state.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class TxSendFormBuildingState extends TxSendFormLoadedState {
  const TxSendFormBuildingState({
    required TokenAmountModel feeTokenAmountModel,
  }) : super(feeTokenAmountModel: feeTokenAmountModel);
}
