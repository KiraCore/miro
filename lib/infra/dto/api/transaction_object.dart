abstract class TransactionObject {
  String get hash;

  int get time;

  List<TransactionDetails> get txs;
}

abstract class TransactionDetails {
  String get address;

  String get type;

  String get denom;

  int get amount;
}
