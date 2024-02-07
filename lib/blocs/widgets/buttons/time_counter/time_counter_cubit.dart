import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/buttons/time_counter/time_counter_state.dart';

class TimeCounterCubit extends Cubit<TimeCounterState> {
  Timer? timer;

  TimeCounterCubit() : super(const TimeCounterState(remainingUnlockTime: Duration.zero));

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  void startCounting(DateTime expirationTime) {
    timer?.cancel();
    Duration remainingUnlockTime = _calculateRemainingUnlockTime(expirationTime);
    emit(TimeCounterState(remainingUnlockTime: remainingUnlockTime));
    timer = Timer.periodic(const Duration(seconds: 1), _handleTimerTick);
  }

  Duration _calculateRemainingUnlockTime(DateTime expirationTime) {
    Duration timeToExpiry = expirationTime.difference(DateTime.now());
    return timeToExpiry < Duration.zero ? Duration.zero : timeToExpiry;
  }

  void _handleTimerTick(Timer timer) {
    if (state.remainingUnlockTime.inSeconds > 0) {
      emit(TimeCounterState(remainingUnlockTime: state.remainingUnlockTime - const Duration(seconds: 1)));
    } else {
      timer.cancel();
      emit(const TimeCounterState(remainingUnlockTime: Duration.zero));
    }
  }
}
