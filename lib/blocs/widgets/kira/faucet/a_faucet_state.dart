import 'package:equatable/equatable.dart';

abstract class AFaucetState extends Equatable {
  final String? hash;
  final String? error;

  const AFaucetState({
    this.hash,
    this.error,
  });

  @override
  List<Object?> get props => <Object?>[hash, error];
}
