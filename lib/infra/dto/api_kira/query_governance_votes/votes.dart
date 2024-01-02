import 'package:equatable/equatable.dart';

class Votes extends Equatable {
  final int proposalId;
  final String voter;
  final String option;

  const Votes({
    required this.proposalId,
    required this.voter,
    required this.option,
  });

  factory Votes.fromJson(Map<String, dynamic> json) => Votes(
        proposalId: json['proposal_id'] as int,
        voter: json['voter'] as String,
        option: json['option'] as String,
      );

  @override
  List<Object> get props => <Object>[proposalId, voter, option];
}
