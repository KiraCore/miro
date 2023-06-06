import 'package:miro/infra/dto/shared/coin.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';

/// Message to send coins from one account to another
/// Represents MsgSend interface from Cosmos SDK:
/// https://github.com/cosmos/groups-ui/blob/master/src/generated/cosmos/bank/v1beta1/tx.ts
class MsgSend extends ATxMsg {
  /// Bech32 address of the sender.
  final String fromAddress;

  /// Bech32 address of the recipient.
  final String toAddress;

  /// Coins that will be sent.
  final List<Coin> amount;

  /// Public constructor.
  const MsgSend({
    required this.fromAddress,
    required this.toAddress,
    required this.amount,
  }) : super(
          messageType: '/cosmos.bank.v1beta1.MsgSend',
          signatureMessageType: 'cosmos-sdk/MsgSend',
        );

  factory MsgSend.fromJson(Map<String, dynamic> json) {
    return MsgSend(
      fromAddress: json['from_address'] as String,
      toAddress: json['to_address'] as String,
      amount: (json['amount'] as List<dynamic>).map((dynamic e) => Coin.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'from_address': fromAddress,
      'to_address': toAddress,
      'amount': amount.map((Coin coin) => coin.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => <Object?>[fromAddress, toAddress, amount];
}
