import 'package:equatable/equatable.dart';

class TimeCounterState extends Equatable {
  final Duration remainingUnlockTime;

  const TimeCounterState({
    required this.remainingUnlockTime,
  });

  bool get isUnlocked => remainingUnlockTime == Duration.zero;

  @override
  List<Object?> get props => <Object?>[remainingUnlockTime];
}