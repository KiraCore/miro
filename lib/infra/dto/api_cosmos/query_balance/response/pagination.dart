class Pagination {
  final String? total;
  final String? nextKey;

  Pagination({
    required this.total,
    required this.nextKey,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json['total'] as String?,
        nextKey: json['next_key'] as String?,
      );

  @override
  String toString() {
    return 'Pagination{total: $total, nextKey: $nextKey}';
  }
}
