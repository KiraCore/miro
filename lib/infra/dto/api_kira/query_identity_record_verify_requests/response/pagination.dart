import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final String? total;
  final String? nextKey;

  const Pagination({
    this.total,
    this.nextKey,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json['total'] as String?,
        nextKey: json['next_key'] as String?,
      );

  @override
  String toString() {
    return 'Pagination{total: $total, nextKey: $nextKey}';
  }

  @override
  List<Object?> get props => <Object?>[
        total,
        nextKey,
      ];
}
