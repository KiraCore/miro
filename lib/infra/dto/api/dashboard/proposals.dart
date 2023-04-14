import 'package:equatable/equatable.dart';

class Proposals extends Equatable {
  final int total;
  final int active;
  final int enacting;
  final int finished;
  final int successful;
  final String proposers;
  final String voters;

  const Proposals({
    required this.total,
    required this.active,
    required this.enacting,
    required this.finished,
    required this.successful,
    required this.proposers,
    required this.voters,
  });

  factory Proposals.fromJson(Map<String, dynamic> json) {
    return Proposals(
      total: json['total'] as int,
      active: json['active'] as int,
      enacting: json['enacting'] as int,
      finished: json['finished'] as int,
      successful: json['successful'] as int,
      proposers: json['proposers'] as String,
      voters: json['voters'] as String,
    );
  }

  @override
  List<Object?> get props => <Object>[total, active, enacting, finished, successful, proposers, voters];
}
