import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/wallet.dart';

class WalletProvider extends ChangeNotifier {
  Wallet? _currentWallet;

  Wallet? get currentWallet => _currentWallet;

  bool get isLoggedIn {
    return _currentWallet != null;
  }

  void updateWallet(Wallet newWallet) {
    _currentWallet = newWallet;
    notifyListeners();
  }

  void logout(BuildContext context) {
    _currentWallet = null;
    AutoRouter.of(context).refresh();
    notifyListeners();
  }
}
