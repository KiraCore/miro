import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/coin.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';

abstract class MsgFormController<MsgFormType extends TxMsg> extends ChangeNotifier {
  final String fee;
  ValueNotifier<String?> errorMessageNotifier = ValueNotifier<String?>(null);

  MsgFormController({
    required this.fee,
  });

  String? validateForm() {
    String? errorMessage = getErrorMessage();
    setErrorMessage(errorMessage: errorMessage);
    return errorMessage;
  }

  String? getErrorMessage();

  void setErrorMessage({required String? errorMessage}) {
    errorMessageNotifier.value = errorMessage;
    notifyListeners();
  }

  UnsignedTransaction? save() {
    TxFee transactionFee = _getTransactionFee();
    TxMsg? message = getTransactionMessage();
    if (message == null) {
      return null;
    }
    UnsignedTransaction unsignedTransaction = UnsignedTransaction(
      fee: transactionFee,
      memo: getMemo() ?? '',
      messages: <TxMsg>[
        message,
      ],
    );
    return unsignedTransaction;
  }

  MsgFormType? getTransactionMessage();

  String? getMemo();

  TxFee _getTransactionFee() {
    Coin amount = Coin(
      value: BigInt.parse(fee),
      denom: 'ukex',
    );

    return TxFee(
      amount: <Coin>[
        amount,
      ],
    );
  }
}
