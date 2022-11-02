import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/router/kira_router.dart';
import 'package:miro/shared/router/router.gr.dart';

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
    KiraRouter.of(context).navigate(const DashboardRoute());
    notifyListeners();
  }
}
