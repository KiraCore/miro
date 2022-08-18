/// Parent class to define transaction messages methods
abstract class ITxMsg {
  Map<String, dynamic> toJson();

  Map<String, dynamic> toSignatureJson();
}
