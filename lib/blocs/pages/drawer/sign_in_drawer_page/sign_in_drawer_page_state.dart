import 'package:equatable/equatable.dart';

class SignInDrawerPageState extends Equatable {
  final bool disabledBool;
  final bool refreshingBool;
  final DateTime? refreshUnlockingDateTime;

  const SignInDrawerPageState({
    required this.disabledBool,
    this.refreshingBool = false,
    this.refreshUnlockingDateTime,
  });

  SignInDrawerPageState copyWith({
    bool? disabledBool,
    bool? refreshingBool,
    DateTime? refreshUnlockingDateTime,
  }) {
    return SignInDrawerPageState(
      disabledBool: disabledBool ?? this.disabledBool,
      refreshingBool: refreshingBool ?? this.refreshingBool,
      refreshUnlockingDateTime: refreshUnlockingDateTime ?? this.refreshUnlockingDateTime,
    );
  }

  @override
  List<Object?> get props => <Object?>[disabledBool, refreshingBool, refreshUnlockingDateTime];
}
