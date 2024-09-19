import 'package:flutter/cupertino.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier {
  List<String> currentAddresses = <String>[];

  int? currentChain;

  bool get isEnabled => ethereum != null;

  bool get isConnected => isEnabled && mainAddress != null;

  String? get mainAddress => currentAddresses.isNotEmpty ? currentAddresses.first : null;

  Web3Provider? get _provider => ethereum == null ? null : Web3Provider.fromEthereum(ethereum!);

  Future<void> connect() async {
    if (isEnabled) {
      final List<String> accounts = await ethereum!.requestAccount();
      currentAddresses = accounts.toList();
      debugPrint('currentAddresses: $currentAddresses');

      currentChain = await ethereum!.getChainId();

      notifyListeners();
    }
  }

  Future<void> pay({required String to, required int amount}) async {
    if (isConnected) {
      await _provider!.getSigner().sendTransaction(
            TransactionRequest(
              from: '0xb83DF76e62980BDb0E324FC9Ce3e7bAF6309E7b5', //mainAddress!,
              to: to,
              value: BigInt.from(0),
            ),
          );
    }
  }

  void clear() {
    currentAddresses.clear();
    currentChain = null;
  }

  void init() {
    if (isEnabled) {
      ethereum!.removeAllListeners('accountsChanged');
      ethereum!.removeAllListeners('chainChanged');

      ethereum!.onAccountsChanged(_onAccountsChanged);
      ethereum!.onChainChanged(_onChainChanged);
    }
  }

  void _onAccountsChanged(List<String> accounts) {
    debugPrint('accountsChanged: $accounts');
  }

  void _onChainChanged(int chain) {
    debugPrint('chainChanged: $chain');
  }

  @override
  void dispose() {
    ethereum?.removeAllListeners();
    clear();
    super.dispose();
  }
}
