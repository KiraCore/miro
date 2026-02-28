import 'package:miro/blocs/pages/transactions/tx_broadcast/a_tx_broadcast_state.dart';
import 'package:miro/infra/dto/api_kira/broadcast/response/broadcast_resp.dart';

class TxBroadcastCompletedState extends ATxBroadcastState {
  final BroadcastResp broadcastResp;

  const TxBroadcastCompletedState({
    required this.broadcastResp,
  });

  @override
  List<Object?> get props => <Object>[broadcastResp];
}
