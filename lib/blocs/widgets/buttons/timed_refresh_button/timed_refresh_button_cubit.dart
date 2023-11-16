import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miro/blocs/widgets/buttons/timed_refresh_button/timed_refresh_button_state.dart';

class TimedRefreshButtonCubit extends Cubit<TimedRefreshButtonState> {
  Timer? timer;

  TimedRefreshButtonCubit() : super(const TimedRefreshButtonState(remainingUnlockTime: Duration.zero));

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }

  void startCounting(DateTime expirationTime) {
    timer?.cancel();
    Duration remainingUnlockTime = _calculateRemainingUnlockTime(expirationTime);
    emit(TimedRefreshButtonState(remainingUnlockTime: remainingUnlockTime));
    timer = Timer.periodic(const Duration(seconds: 1), _handleTimerTick);
  }

  Duration _calculateRemainingUnlockTime(DateTime expirationTime) {
    Duration timeToExpiry = expirationTime.difference(DateTime.now());
    return timeToExpiry < Duration.zero ? Duration.zero : timeToExpiry;
  }

  void _handleTimerTick(Timer timer) {
    if (state.remainingUnlockTime.inSeconds > 0) {
      emit(TimedRefreshButtonState(remainingUnlockTime: state.remainingUnlockTime - const Duration(seconds: 1)));
    } else {
      timer.cancel();
      emit(const TimedRefreshButtonState(remainingUnlockTime: Duration.zero));
    }
  }
}
