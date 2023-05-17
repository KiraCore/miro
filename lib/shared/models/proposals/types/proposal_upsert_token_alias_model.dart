import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/api_kira/query_proposals/response/types/proposal_upsert_token_alias.dart';
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

  factory ProposalUpsertTokenAliasModel.fromDto(ProposalUpsertTokenAlias proposalUpsertTokenAlias) {
    return ProposalUpsertTokenAliasModel(
      proposalType: ProposalType.fromString(proposalUpsertTokenAlias.type),
      name: proposalUpsertTokenAlias.name,
      decimals: proposalUpsertTokenAlias.decimals,
      denoms: proposalUpsertTokenAlias.denoms,
      icon: proposalUpsertTokenAlias.icon,
      symbol: proposalUpsertTokenAlias.symbol,
      invalidatedBool: proposalUpsertTokenAlias.invalidatedBool,
    );
  }

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
    return S.of(context).proposalTypeUpsertTokenAlias;
  }

  @override
  List<Object?> get props => <Object?>[decimals, icon, name, symbol, denoms, invalidatedBool];
}
