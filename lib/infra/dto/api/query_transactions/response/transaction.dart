import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

class Transaction extends Equatable {
  final int time;
  final String hash;
  final String status;
  final String direction;
  final String memo;
  final List<Coin> fee;
  final List<ATxMsg> txs;

  const Transaction({
    required this.time,
    required this.hash,
    required this.status,
    required this.direction,
    required this.memo,
    required this.fee,
    required this.txs,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      time: json['time'] as int,
      hash: json['hash'] as String,
      status: json['status'] as String,
      direction: json['direction'] as String,
      memo: json['memo'] as String,
      fee: (json['fee'] as List<dynamic>).map((dynamic e) => Coin.fromJson(e as Map<String, dynamic>)).toList(),
      txs: (json['txs'] as List<dynamic>).map((dynamic e) => ATxMsg.buildFromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[time, hash, status, direction, memo, fee, txs];
}
