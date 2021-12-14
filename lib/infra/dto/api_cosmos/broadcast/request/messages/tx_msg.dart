/// Parent class to define transaction messages methods
abstract class TxMsg {
  Map<String, dynamic> toJson();

  Map<String, dynamic> toSignatureJson();
}
