import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/unsigned_transaction.dart';

class TransactionFormController extends ChangeNotifier {
  late bool Function() validate;
  late UnsignedTransaction Function() buildTransaction;

  bool valid = false;

  void setUpController({
    required bool Function() validate,
    required UnsignedTransaction Function() buildTransaction,
  }) {
    this.validate = validate;
    this.buildTransaction = buildTransaction;
  }

  void updateFormValidation() {
    valid = validate();
    notifyListeners();
  }
}
