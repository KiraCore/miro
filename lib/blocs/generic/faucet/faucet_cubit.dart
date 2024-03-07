import 'package:flutter_bloc/flutter_bloc.dart';

part 'faucet_state.dart';

class FaucetCubit extends Cubit<FaucetState> {
  FaucetCubit() : super(FaucetInitial());
}
