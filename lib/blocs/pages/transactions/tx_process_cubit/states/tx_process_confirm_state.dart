import 'package:miro/blocs/pages/transactions/tx_process_cubit/a_tx_process_state.dart';
import 'package:miro/blocs/pages/transactions/tx_process_cubit/states/tx_process_loaded_state.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';

class TxProcessConfirmState extends ATxProcessState {
  final TxProcessLoadedState txProcessLoadedState;
  final SignedTxModel signedTxModel;

  const TxProcessConfirmState({
    required this.txProcessLoadedState,
    required this.signedTxModel,
  });

  @override
  List<Object?> get props => <Object>[txProcessLoadedState, signedTxModel];
}
