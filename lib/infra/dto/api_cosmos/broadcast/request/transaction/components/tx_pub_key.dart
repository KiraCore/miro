/// PubKey defines a secp256k1 public key Key is the compressed form of the pubkey.
/// The first byte depends is a 0x02 byte if the y-coordinate is the lexicographically
/// largest of the two associated with the x-coordinate.
/// Otherwise the first byte is a 0x03. This prefix is followed with the x-coordinate.
///
/// https://docs.cosmos.network/v0.44/core/proto-docs.html#cosmos.crypto.secp256k1.PubKey
class TxPubKey {
  /// Backend mapping class type
  final String type = '/cosmos.crypto.secp256k1.PubKey';

  /// Public key value
  final String key;

  TxPubKey({
    required this.key,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      '@type': type,
      'key': key,
    };
  }
}
