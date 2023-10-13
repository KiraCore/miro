import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

class MsgDelegate extends ATxMsg {
  final String delegatorAddress;
  final String valoperAddress;
  final List<Coin> amounts;

  const MsgDelegate({
    required this.delegatorAddress,
    required this.valoperAddress,
    required this.amounts,
  }) : super(
          messageType: '/kira.multistaking.MsgDelegate',
          signatureMessageType: 'kiraHub/MsgDelegate',
        );

  factory MsgDelegate.fromJson(Map<String, dynamic> json) {
    return MsgDelegate(
      delegatorAddress: json['delegator_address'] as String,
      valoperAddress: json['validator_address'] as String,
      amounts: (json['amounts'] as List<dynamic>).map((dynamic e) => Coin.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'delegator_address': delegatorAddress,
      'validator_address': valoperAddress,
      'amounts': amounts.map((Coin coin) => coin.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => <Object>[delegatorAddress, valoperAddress, amounts];
}
