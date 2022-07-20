import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class MsgSendFormModel {
  final ValueNotifier<WalletAddress?> fromWalletAddressNotifier = ValueNotifier<WalletAddress?>(null);
  WalletAddress? toWalletAddress;
  TokenAmount? tokenAmount;
  TextEditingController memoTextEditingController = TextEditingController();

  String? getErrorMessage() {
    if (fromWalletAddressNotifier.value == null) {
      return 'Sender address empty';
    } else if (toWalletAddress == null) {
      return 'Recipient address empty';
    } else if (tokenAmount == null) {
      return 'Token amount empty';
    } else {
      return null;
    }
  }

  MsgSend buildTransactionMessage() {
    return MsgSend(
      fromAddress: fromWalletAddressNotifier.value!,
      toAddress: toWalletAddress!,
      amount: <Coin>[
        Coin(
          denom: tokenAmount!.tokenAliasModel.lowestTokenDenomination.name,
          value: tokenAmount!.getAsLowestDenomination().toBigInt(),
        ),
      ],
    );
  }
}
