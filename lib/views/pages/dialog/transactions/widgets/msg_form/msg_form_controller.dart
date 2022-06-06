import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';

class MsgFormController extends ChangeNotifier {
  late UnsignedTransaction Function() buildTransaction;

  String? errorMessage;

  void setUpController({
    required UnsignedTransaction Function() buildTransaction,
  }) {
    this.buildTransaction = buildTransaction;
  }

  void setErrorMessage({required String? errorMessage}) {
    this.errorMessage = errorMessage;
    notifyListeners();
  }
}
