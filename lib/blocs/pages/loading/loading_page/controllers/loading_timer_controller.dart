import 'dart:async';

import 'package:flutter/material.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';

class LoadingTimerController {
  final AppConfig appConfig = globalLocator<AppConfig>();

  final Completer<void> loadingCompleter = Completer<void>();
  final VoidCallback onTimeExpired;

  late final ValueNotifier<int> timeNotifier;
  late final Timer timer;

  LoadingTimerController({required this.onTimeExpired}) {
    timer = Timer.periodic(const Duration(seconds: 1), _handleTimerTick);
    timeNotifier = ValueNotifier<int>(appConfig.loadingPageTimerDuration.inSeconds);
  }

  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    timeNotifier.dispose();
  }

  void _handleTimerTick(Timer timer) {
    int secondsRemaining = timeNotifier.value - 1;
    timeNotifier.value = secondsRemaining;
    if (secondsRemaining == 0) {
      loadingCompleter.complete();
      timer.cancel();
      onTimeExpired();
    }
  }
}
