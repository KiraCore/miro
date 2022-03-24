import 'package:miro/infra/dto/api/transaction_object.dart';

class WithdrawsTx extends TransactionDetails {
  @override
  final String address;

  @override
  final String type;

  @override
  final String denom;

  @override
  final int amount;

  WithdrawsTx({
    required this.address,
    required this.type,
    required this.denom,
    required this.amount,
  });

  factory WithdrawsTx.fromJson(Map<String, dynamic> json) => WithdrawsTx(
        address: json['address'] as String,
        type: json['type'] as String,
        denom: json['denom'] as String,
        amount: json['amount'] as int,
      );

  @override
  String toString() {
    return 'WithdrawsTx{address: $address, type: $type, denom: $denom, amount: $amount}';
  }
}
