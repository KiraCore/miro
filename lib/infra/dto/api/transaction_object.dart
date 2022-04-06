import 'package:equatable/equatable.dart';

abstract class TransactionObject extends Equatable {
  String get hash;

  int get time;

  List<TransactionDetails> get txs;

  @override
  List<Object> get props => <Object>[hash];
}

abstract class TransactionDetails {
  String get address;

  String get type;

  String get denom;

  int get amount;
}
