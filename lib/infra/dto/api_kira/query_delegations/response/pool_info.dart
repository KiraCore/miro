import 'package:equatable/equatable.dart';

class PoolInfo extends Equatable {
  final int id;
  final String commission;
  final String status;
  final List<String> tokens;

  const PoolInfo({
    required this.id,
    required this.commission,
    required this.status,
    required this.tokens,
  });

  factory PoolInfo.fromJson(Map<String, dynamic> json) {
    return PoolInfo(
      id: json['id'] as int,
      commission: json['commission'] as String,
      status: json['status'] as String,
      tokens: (json['tokens'] as List<dynamic>).map((dynamic e) => e as String).toList(),
    );
  }

  @override
  List<Object?> get props => <Object?>[id, commission, status, tokens];
}
