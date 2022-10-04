import 'package:miro/blocs/specific_blocs/transactions/tx_broadcast/a_tx_broadcast_state.dart';
import 'package:miro/shared/models/transactions/broadcast_resp_model.dart';

class TxBroadcastCompletedState extends ATxBroadcastState {
  final BroadcastRespModel broadcastRespModel;

  TxBroadcastCompletedState({
    required this.broadcastRespModel,
  });

  @override
  List<Object?> get props => <Object>[broadcastRespModel];
}
