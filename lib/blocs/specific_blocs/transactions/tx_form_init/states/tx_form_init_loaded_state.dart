import 'package:miro/blocs/specific_blocs/transactions/tx_form_init/a_tx_form_init_state.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class TxFormInitLoadedState extends ATxFormInitState {
  final TokenAmountModel feeTokenAmountModel;

  const TxFormInitLoadedState({
    required this.feeTokenAmountModel,
  });

  @override
  List<Object> get props => <Object>[feeTokenAmountModel];
}
