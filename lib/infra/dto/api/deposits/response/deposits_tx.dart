import 'package:miro/infra/dto/api/transaction_object.dart';

class DepositsTx extends TransactionDetails {
  @override
  final String address;

  @override
  final String type;

  @override
  final String denom;

  @override
  final int amount;

  DepositsTx({
    required this.address,
    required this.type,
    required this.denom,
    required this.amount,
  });

  factory DepositsTx.fromJson(Map<String, dynamic> json) => DepositsTx(
        address: json['address'] as String,
        type: json['type'] as String,
        denom: json['denom'] as String,
        amount: json['amount'] as int,
      );

  @override
  String toString() {
    return 'DepositsTx{address: $address, type: $type, denom: $denom, amount: $amount}';
  }
}
