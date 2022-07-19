import 'dart:typed_data';

class Bech32Pair {
  final String hrp;
  final Uint8List data;

  Bech32Pair({
    required this.hrp,
    required this.data,
  });
}
