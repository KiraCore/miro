import 'package:miro/blocs/pages/transactions/tx_broadcast/a_tx_broadcast_state.dart';
import 'package:miro/shared/models/network/error_explorer_model.dart';

class TxBroadcastErrorState extends ATxBroadcastState {
  final ErrorExplorerModel errorExplorerModel;

  const TxBroadcastErrorState({
    required this.errorExplorerModel,
  });

  @override
  List<Object?> get props => <Object?>[errorExplorerModel];
}
