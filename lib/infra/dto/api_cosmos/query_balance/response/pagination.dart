class Pagination {
  final String total;

  Pagination({required this.total});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json['total'] as String,
  );

  @override
  String toString() {
    return 'Pagination{total: $total}';
  }
}