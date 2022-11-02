import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/dashboard/proposals.dart';

class ProposalsModel extends Equatable {
  final int total;
  final int active;
  final int enacting;
  final int finished;
  final int successful;
  final String proposers;
  final String voters;

  const ProposalsModel({
    required this.total,
    required this.active,
    required this.enacting,
    required this.finished,
    required this.successful,
    required this.proposers,
    required this.voters,
  });

  factory ProposalsModel.fromDto(Proposals proposals) {
    return ProposalsModel(
      total: proposals.total,
      active: proposals.active,
      enacting: proposals.enacting,
      finished: proposals.finished,
      successful: proposals.successful,
      proposers: proposals.proposers,
      voters: proposals.voters,
    );
  }

  @override
  List<Object?> get props => <Object>[total, active, enacting, finished, successful, proposers, voters];
}
