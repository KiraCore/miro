import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/kira/faucet/a_faucet_state.dart';
import 'package:miro/blocs/widgets/kira/faucet/states/faucet_error_state.dart';
import 'package:miro/blocs/widgets/kira/faucet/states/faucet_loaded_state.dart';
import 'package:miro/blocs/widgets/kira/faucet/states/faucet_loading_state.dart';
import 'package:miro/infra/services/api_kira/query_kira_faucet_service.dart';
import 'package:miro/shared/models/faucet/faucet_model.dart';

class FaucetCubit extends Cubit<AFaucetState> {
  final QueryKiraFaucetService _queryKiraFaucetService = QueryKiraFaucetService();

  FaucetCubit() : super(FaucetLoadingState());

  // Future<void> claimTokens(QueryFaucetReq request) async {
  //   emit(FaucetLoadingState() as AFaucetState);
  //   try {
  //     const String hash = '';
  //
  //     emit(const FaucetSuccessState(hash: hash) as AFaucetState);
  //   } catch (e) {
  //     emit(FaucetErrorState());
  //   }
  // }

  Future<void> getFaucetInfo() async {
    emit(FaucetLoadingState());
    try {
      FaucetModel faucetModel = await _queryKiraFaucetService.getFaucetInfo();

      emit(FaucetLoadedState(faucetModel: faucetModel));
    } catch (e) {
      emit(FaucetErrorState());
    }
  }
}
