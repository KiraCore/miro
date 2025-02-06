class Parts {
  final String hash;
  final int total;

  Parts({required this.hash, required this.total});

  factory Parts.fromJson(Map<String, dynamic> json) => Parts(
        hash: json['hash'] as String,
        total: json['total'] as int,
      );
}
