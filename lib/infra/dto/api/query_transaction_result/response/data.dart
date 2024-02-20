import 'package:miro/infra/dto/shared/coin.dart';

class Data {
  final String fromAddress;
  final String toAddress;
  final List<Coin> amount;

  Data({
    required this.fromAddress,
    required this.toAddress,
    required this.amount,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      fromAddress: json['from_address'] as String,
      toAddress: json['to_address'] as String,
      amount: (json['amounts'] as List<dynamic>).map((dynamic e) => Coin.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
