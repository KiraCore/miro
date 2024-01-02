import 'package:equatable/equatable.dart';

class ProposalContent extends Equatable {
  final bool invalidated;
  final int decimals;
  final String icon;
  final String name;
  final String symbol;
  final String type;
  final List<String> denoms;

  const ProposalContent({
    required this.invalidated,
    required this.decimals,
    required this.icon,
    required this.name,
    required this.symbol,
    required this.type,
    required this.denoms,
  });

  factory ProposalContent.fromJson(Map<String, dynamic> json) => ProposalContent(
        type: json['@type'] as String,
        decimals: json['decimals'] as int,
        denoms: json['denoms'] as List<String>,
        icon: json['icon'] as String,
        invalidated: json['invalidated'] as bool,
        name: json['name'] as String,
        symbol: json['symbol'] as String,
      );

  @override
  List<Object> get props => <Object>[
        invalidated,
        decimals,
        icon,
        name,
        symbol,
        type,
        denoms,
      ];
}
