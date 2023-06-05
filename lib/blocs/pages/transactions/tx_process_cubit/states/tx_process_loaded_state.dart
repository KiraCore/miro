import 'package:miro/blocs/pages/transactions/tx_process_cubit/a_tx_process_state.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class TxProcessLoadedState extends ATxProcessState {
  final TokenAmountModel feeTokenAmountModel;

  const TxProcessLoadedState({
    required this.feeTokenAmountModel,
  });

  @override
  List<Object?> get props => <Object>[feeTokenAmountModel];
}
