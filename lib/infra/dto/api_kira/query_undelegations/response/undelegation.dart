import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/infra/dto/shared/validator_info.dart';

class Undelegation extends Equatable {
  final int id;
  final ValidatorInfo validatorInfo;
  final List<Coin> tokens;
  final String expiry;

  const Undelegation({
    required this.id,
    required this.validatorInfo,
    required this.tokens,
    required this.expiry,
  });

  factory Undelegation.fromJson(Map<String, dynamic> json) {
    List<dynamic> coinList = json['tokens'] != null ? json['tokens'] as List<dynamic> : List<dynamic>.empty();

    return Undelegation(
      id: json['id'] as int,
      validatorInfo: ValidatorInfo.fromJson(json['validator_info'] as Map<String, dynamic>),
      tokens: coinList.map((dynamic e) => Coin.fromJson(e as Map<String, dynamic>)).toList(),
      expiry: json['expiry'] as String,
    );
  }

  @override
  List<Object?> get props => <Object?>[id, validatorInfo, tokens, expiry];
}
