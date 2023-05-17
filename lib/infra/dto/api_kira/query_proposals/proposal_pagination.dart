import 'package:equatable/equatable.dart';

class ProposalPagination extends Equatable {
  final String nextKey;
  final String total;

  const ProposalPagination({
    required this.nextKey,
    required this.total,
  });

  factory ProposalPagination.fromJson(Map<String, dynamic> json) {
    return ProposalPagination(
      nextKey: json['next_key'] as String,
      total: json['total'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[nextKey, total];
}
