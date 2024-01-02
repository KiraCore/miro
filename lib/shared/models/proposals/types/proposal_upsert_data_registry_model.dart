import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/shared/models/proposals/a_proposal_type_content_model.dart';
import 'package:miro/shared/models/proposals/proposal_type.dart';

class ProposalUpsertDataRegistryModel extends AProposalTypeContentModel {
  final String encoding;
  final String hash;
  final String key;
  final String reference;
  final String size;

  const ProposalUpsertDataRegistryModel({
    required ProposalType proposalType,
    required this.encoding,
    required this.hash,
    required this.key,
    required this.reference,
    required this.size,
  }) : super(proposalType: proposalType);

  @override
  Map<String, dynamic> getProposalContentValues() {
    return <String, dynamic>{
      'encoding': encoding,
      'hash': hash,
      'key': key,
      'reference': reference,
      'size': size,
    };
  }

  @override
  String getProposalTitle(BuildContext context) {
    return S.of(context).proposalTypeUpsertDataRegistry;
  }

  @override
  List<Object> get props => <Object>[encoding, hash, key, reference, size];
}
