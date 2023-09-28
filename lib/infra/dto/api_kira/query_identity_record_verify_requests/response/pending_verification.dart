import 'package:equatable/equatable.dart';

class PendingVerification extends Equatable {
  final String verifierAddress;
  final List<String> recordIds;

  const PendingVerification({
    required this.verifierAddress,
    required this.recordIds,
  });

  @override
  List<Object?> get props => <Object?>[verifierAddress, recordIds];
}
