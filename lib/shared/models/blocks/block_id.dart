class BlockId {
  final String hash;

  BlockId({required this.hash});

  factory BlockId.fromJson(Map<String, dynamic> json) => BlockId(
        hash: json['hash'] as String,
      );
}
