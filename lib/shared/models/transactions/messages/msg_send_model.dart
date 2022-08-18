import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/i_tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/i_tx_msg_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class MsgSendModel extends Equatable implements ITxMsgModel {
  final WalletAddress fromWalletAddress;
  final WalletAddress toWalletAddress;
  final TokenAmountModel tokenAmountModel;

  const MsgSendModel({
    required this.fromWalletAddress,
    required this.toWalletAddress,
    required this.tokenAmountModel,
  });

  factory MsgSendModel.fromMsgDto(MsgSend msgSend) {
    return MsgSendModel(
      fromWalletAddress: WalletAddress.fromBech32(msgSend.fromAddress),
      toWalletAddress: WalletAddress.fromBech32(msgSend.toAddress),
      tokenAmountModel: TokenAmountModel(
        lowestDenominationAmount: Decimal.parse(msgSend.amount.first.denom),
        tokenAliasModel: TokenAliasModel.local(msgSend.amount.first.denom),
      ),
    );
  }

  @override
  ITxMsg toMsgDto() {
    return MsgSend(
      fromAddress: fromWalletAddress.bech32Address,
      toAddress: toWalletAddress.bech32Address,
      amount: <Coin>[
        Coin(
          denom: tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name,
          amount: tokenAmountModel.getAmountInLowestDenomination().toString(),
        ),
      ],
    );
  }

  @override
  List<Object?> get props => <Object>[fromWalletAddress, toWalletAddress, tokenAmountModel];
}
