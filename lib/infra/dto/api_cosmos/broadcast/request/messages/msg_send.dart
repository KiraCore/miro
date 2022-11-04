import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/a_tx_msg.dart';

/// [MsgSend] represents the message that should be
/// used when sending tokens from one user to another one.
/// It requires to specify the address from which to send the tokens,
/// the one that should receive the tokens and the amount of tokens
/// to send.
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
