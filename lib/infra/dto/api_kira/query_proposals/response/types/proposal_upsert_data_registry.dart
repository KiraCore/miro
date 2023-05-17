import 'package:miro/infra/dto/api_kira/query_proposals/a_proposal_type_content.dart';

class ProposalUpsertDataRegistry extends AProposalTypeContent {
  final String encoding;
  final String hash;
  final String key;
  final String reference;
  final String size;

  const ProposalUpsertDataRegistry({
    required String type,
    required this.encoding,
    required this.hash,
    required this.key,
    required this.reference,
    required this.size,
  }) : super(type: type);

  factory ProposalUpsertDataRegistry.fromJson(Map<String, dynamic> json) {
    return ProposalUpsertDataRegistry(
      type: json['@type'] as String,
      encoding: json['encoding'] as String,
      hash: json['hash'] as String,
      key: json['key'] as String,
      reference: json['reference'] as String,
      size: json['size'] as String,
    );
  }

  @override
  List<Object> get props => <Object>[
        encoding,
        hash,
        key,
        reference,
        size,
      ];
}
