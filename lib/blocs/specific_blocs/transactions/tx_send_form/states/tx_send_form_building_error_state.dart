import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/states/tx_send_form_loaded_state.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class TxSendFormBuildingErrorState extends TxSendFormLoadedState {
  const TxSendFormBuildingErrorState({
    required TokenAmountModel feeTokenAmountModel,
  }) : super(feeTokenAmountModel: feeTokenAmountModel);
}
