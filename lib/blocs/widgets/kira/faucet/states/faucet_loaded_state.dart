import 'package:miro/blocs/widgets/kira/faucet/a_faucet_state.dart';
import 'package:miro/shared/models/faucet/faucet_model.dart';

class FaucetLoadedState extends AFaucetState {
  final FaucetModel faucetModel;

  const FaucetLoadedState({required this.faucetModel});
}
