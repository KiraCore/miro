import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:miro/shared/models/wallet/unsafe_wallet.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/models/wallet/wallet_details.dart';

class WalletProvider extends ChangeNotifier {
  Wallet? _currentWallet = mockWallet();

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

  // TODO(dominik): Debug only method
  static Wallet mockWallet() {
    // @formatter:off
    List<int> expectedPublicKey = <int>[2, 82, 218, 179, 192, 137, 234, 89, 185, 201, 146, 124, 135, 69, 57, 66, 239, 103, 205, 91, 224, 190, 201, 32, 30, 229, 17, 60, 29, 227, 189, 76, 124];
    List<int> expectedPrivateKey = <int>[57, 85, 242, 61, 128, 25, 108, 4, 5, 194, 197, 31, 28, 177, 36, 235, 139, 24, 159, 44, 188, 57, 56, 83, 33, 96, 130, 243, 98, 34, 175, 181];
    List<int> expectedAddress = <int>[172, 64, 118, 24, 44, 225, 44, 178, 132, 20, 126, 117, 121, 160, 176, 137, 217, 178, 30, 181];

    // @formatter:on
    Wallet expectedWallet = UnsafeWallet(
      privateKey: Uint8List.fromList(expectedPrivateKey),
      publicKey: Uint8List.fromList(expectedPublicKey),
      address: WalletAddress(
        addressBytes: Uint8List.fromList(expectedAddress),
        bech32Hrp: WalletDetails.defaultWalletDetails.bech32Hrp,
      ),
      walletDetails: WalletDetails.defaultWalletDetails,
    );
    return expectedWallet;
  }
}
