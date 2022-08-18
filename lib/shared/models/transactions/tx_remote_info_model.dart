import 'package:equatable/equatable.dart';

class TxRemoteInfoModel extends Equatable {
  final String accountNumber;
  final String chainId;
  final String sequence;

  const TxRemoteInfoModel({
    required this.accountNumber,
    required this.chainId,
    String? sequence,
  }) : sequence = sequence ?? '0';

  @override
  List<Object?> get props => <Object>[accountNumber, chainId, sequence];
}
