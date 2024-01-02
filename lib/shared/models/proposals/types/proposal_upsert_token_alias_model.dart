import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalUpsertTokenAliasModel extends AProposalTypeContentModel {
  final int decimals;
  final String icon;
  final String name;
  final String symbol;
  final List<String> denoms;
  final bool? invalidatedBool;

  const ProposalUpsertTokenAliasModel({
    required ProposalType proposalType,
    required this.decimals,
    required this.icon,
    required this.name,
    required this.symbol,
    required this.denoms,
    this.invalidatedBool,
  }) : super(proposalType: proposalType);

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'decimals': decimals,
      'icon': icon,
      'name': name,
      'symbol': symbol,
      'denoms': denoms,
      'invalidated': invalidatedBool,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeUpsertDataRegistry;
  }

  @override
  List<Object?> get props => <Object?>[decimals, icon, name, symbol, denoms, invalidatedBool];
}
