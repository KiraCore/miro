import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_controller.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_amount.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/models/token_denomination.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/token_section/token_section_controller.dart';

class MsgSendFormController extends MsgFormController<MsgSend> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<WalletAddress?> fromAddress = ValueNotifier<WalletAddress?>(null);
  final ValueNotifier<WalletAddress?> toAddress = ValueNotifier<WalletAddress?>(null);
  final TextEditingController memoTextEditingController = TextEditingController();
  final TokenSectionController tokenSectionController = TokenSectionController();
  TokenAmount? tokenAmount;

  MsgSendFormController({
    required String fee,
  }) : super(fee: fee);

  @override
  String? getErrorMessage() {
    String? senderAddressErrorMessage = fromAddress.value == null ? 'Sender address is required' : null;
    String? recipientAddressErrorMessage = toAddress.value == null ? 'Recipient address is required' : null;
    String? amountErrorMessage = tokenSectionController.validate();

    return senderAddressErrorMessage ?? recipientAddressErrorMessage ?? amountErrorMessage;
  }

  @override
  MsgSend? getTransactionMessage() {
    TokenDenomination? lowestTokenDenomination = tokenSectionController.selectedTokenType?.lowestTokenDenomination;
    if (lowestTokenDenomination == null || tokenAmount == null) {
      return null;
    }
    BigInt lowestTokenAmount = tokenAmount!.calculateAmountAsDenomination(lowestTokenDenomination).toBigInt();

    return MsgSend(
      fromAddress: fromAddress.value!,
      toAddress: toAddress.value!,
      amount: <Coin>[
        Coin(
          value: lowestTokenAmount,
          denom: lowestTokenDenomination.name,
        ),
      ],
    );
  }

  @override
  String? getMemo() {
    if (memoTextEditingController.text.isEmpty) {
      return 'MsgSend to ${toAddress}';
    }
    return memoTextEditingController.text;
  }

  void updateSenderAddress(WalletAddress? walletAddress) {
    fromAddress.value = walletAddress;
    notifyListeners();
  }

  void updateRecipientAddress(WalletAddress? walletAddress) {
    toAddress.value = walletAddress;
  }

  void onTokenAmountChanged(TokenAmount? tokenAmount) {
    this.tokenAmount = tokenAmount;
  }
}
