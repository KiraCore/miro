import 'package:equatable/equatable.dart';

/// Contains name and assigned decimals for specified token
/// Example:
/// TokenDenomination(name: 'uKEX', decimals: 0)
/// TokenDenomination(name: 'KEX', decimals: 8)
class TokenDenominationModel extends Equatable {
  /// Contains name of denomination
  /// Example KEX, uKEX
  final String name;

  /// Contains decimal number from default (lowest) token denomination
  /// Example: decimals for uKEX equals 0 and for KEX equals 8
  final int decimals;

  const TokenDenominationModel({
    required this.name,
    required this.decimals,
  });

  @override
  List<Object> get props => <Object>[name, decimals];
}
