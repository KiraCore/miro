import 'package:miro/infra/dto/api_kira/query_governance_proposals/a_proposal_type_content.dart';

class ProposalUpsertTokenAlias extends AProposalTypeContent {
  final int decimals;
  final String icon;
  final String name;
  final String symbol;
  final List<String> denoms;
  final bool? invalidatedBool;

  const ProposalUpsertTokenAlias({
    required String type,
    required this.decimals,
    required this.icon,
    required this.name,
    required this.symbol,
    required this.denoms,
    this.invalidatedBool,
  }) : super(type: type);

  factory ProposalUpsertTokenAlias.fromJson(Map<String, dynamic> json) {
    return ProposalUpsertTokenAlias(
      type: json['@type'] as String,
      decimals: json['decimals'] as int,
      icon: json['icon'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      denoms: (json['denoms'] as List<dynamic>).map((dynamic e) => e as String).toList(),
      invalidatedBool: json['invalidated'] as bool,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        decimals,
        icon,
        name,
        symbol,
        denoms,
        invalidatedBool,
      ];
}
