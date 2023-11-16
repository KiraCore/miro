import 'package:equatable/equatable.dart';

class TimedRefreshButtonState extends Equatable {
  final Duration remainingUnlockTime;

  const TimedRefreshButtonState({
    required this.remainingUnlockTime,
  });

  bool get isUnlocked => remainingUnlockTime == Duration.zero;

  @override
  List<Object?> get props => <Object?>[remainingUnlockTime];
}