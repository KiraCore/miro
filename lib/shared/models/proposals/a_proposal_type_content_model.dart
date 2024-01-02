import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

abstract class AProposalTypeContentModel extends Equatable {
  final ProposalType proposalType;

  const AProposalTypeContentModel({required this.proposalType});

  Map<String, dynamic> getProposalContentValues();

  String getProposalTitle(BuildContext context);

  @override
  List<Object?> get props => <Object?>[proposalType];
}
