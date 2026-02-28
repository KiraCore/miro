import 'package:equatable/equatable.dart';

class ProposalsModel extends Equatable {
  final int total;
  final int active;
  final int enacting;
  final int finished;
  final int successful;
  final int proposers;
  final int voters;

  const ProposalsModel({
    required this.total,
    required this.active,
    required this.enacting,
    required this.finished,
    required this.successful,
    required this.proposers,
    required this.voters,
  });

  @override
  List<Object?> get props => <Object>[total, active, enacting, finished, successful, proposers, voters];
}
