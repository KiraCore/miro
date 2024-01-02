import 'package:equatable/equatable.dart';

class Vote extends Equatable {
  final String option;
  final String proposalId;
  final String slash;
  final String voter;

  const Vote({
    required this.option,
    required this.proposalId,
    required this.slash,
    required this.voter,
  });

  factory Vote.fromJson(Map<String, dynamic> json) => Vote(
        option: json['option'] as String,
        proposalId: json['proposal_id'] as String,
        slash: json['slash'] as String,
        voter: json['voter'] as String,
      );

  @override
  List<Object> get props => <Object>[option, proposalId, slash, voter];
}
