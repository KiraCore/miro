import 'package:miro/blocs/specific_blocs/transactions/tx_send_form/a_tx_send_form_state.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class TxSendFormLoadedState extends ATxSendFormState {
  final TokenAmountModel feeTokenAmountModel;

  const TxSendFormLoadedState({
    required this.feeTokenAmountModel,
  });

  @override
  List<Object> get props => <Object>[feeTokenAmountModel];
}
