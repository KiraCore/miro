import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final String total;

  const Pagination({required this.total});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json['total'] as String? ?? '0',
      );

  @override
  List<Object?> get props => <Object?>[total];
}
